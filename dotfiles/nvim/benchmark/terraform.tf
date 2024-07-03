# Data: {{{
data "aws_vpc" "this" {
  default = "${var.vpc_id == "" ? true : false}"
  id      = "${var.vpc_id}"
  vpc_id            = "${data.aws_vpc.this.id}"
  availability_zone = "${local.availability_zone}"
}
# }}}

# Variables: {{{
locals {
  availability_zone = "${data.aws_availability_zones.this.names[0]}"
  reprovision_trigger = <<EOF
    # Trigger reprovision on variable changes:
    ${var.hostname}
    # Trigger reprovision on file changes:
    ${file("${path.module}/provision-swap.sh")}
  EOF
}

variable "hostname" {
  description = "Hostname by which this service is identified in metrics, logs etc"
  default     = "aws-ec2-ebs-docker-host"
}
# }}}
# Main: {{{
resource "aws_instance" "this" {
  instance_type          = "${var.instance_type}"
  availability_zone      = "${local.availability_zone}"
  key_name               = "${aws_key_pair.this.id}"
  vpc_security_group_ids = ["${aws_security_group.this.id}"]
  subnet_id              = "${data.aws_subnet.this.id}"
  user_data              = "${sha1(local.reprovision_trigger)}"
  tags                   = "${merge(var.tags, map("Name", "${var.hostname}"))}"
  count                  = "${var.data_volume_id == "" ? 0 : 1}"

  connection {
    private_key = "${file("${var.ssh_private_key_path}")}"
    agent       = false
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname ${var.hostname}",
      "echo 127.0.0.1 ${var.hostname} | sudo tee -a /etc/hosts",
    ]
    script = "${path.module}/provision-docker.sh"
    destination = "/home/${var.ssh_username}/provision-swap.sh"
  }
}
# }}}
