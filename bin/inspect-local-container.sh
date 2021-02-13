#!/usr/bin/env bash
# vim: ft=sh softtabstop=2 tabstop=2 shiftwidth=2 expandtab autoindent cc=90

set -euo pipefail

source import_ik1614_module utils colors tmux

__SCRIPT_NAME=$(basename ${BASH_SOURCE[0]})

function __show_help() {
  cat << HELP_USAGE

Description:
  Get inside one or more local docker containers selected with 'fzf'

Usage: $__SCRIPT_NAME [-h] [command]

Examples:
  $__SCRIPT_NAME
  $__SCRIPT_NAME /bin/sh

Arguments:
  command
    Command to be executed in the docker container.
    Default is '/bin/bash'

Options:
  -h
    Show this message.

HELP_USAGE
}

while getopts ':h' opt; do
  case "$opt" in
    h)
      __show_help
      exit 0
      ;;
    \?)
      utils::echo_warn "Invalid option: $OPTARG" 1>&2
      ;;
    :)
      utils::echo_warn "Invalid option: $OPTARG requires an argument" 1>&2
      ;;
  esac
done
shift $((OPTIND -1))


### And you are ready to go
function main(){
  local CMD="${1:-/bin/bash}"
  local selected_container_ids
  local commands
  local container_id

  colors::detect_color_support

  selected_container_ids="$(
    set -e
    docker ps --format 'table {{.Names}}\t{{.Command}}\t{{.Image}}\t{{.Size}}' \
      | tail -n +2 \
      | sort \
      | utils::fzf_multi_select "container" \
      | awk '{print $1}'
  )"

  commands=()
  for container_id in ${selected_container_ids[@]}; do
    commands+=("docker exec -it $container_id ${CMD}")
  done

  if [[ ${#commands[@]} -gt 1 ]]; then
    tmux::create_window_cluster "local-container" "${commands[@]}"
  else
    ${commands[0]}
  fi
}

main "${@:-}"
