SHELL = /bin/bash


test-install-profile:
	cd ..
	docker build -t test-install-profile:latest \
				 -f tests/test-install-profile.dockerfile \
				 .
	docker run -it --rm test-install-profile:latest


test-install-config:
	cd ..
	docker build -t test-install-config:latest \
				 -f tests/test-install-config.dockerfile \
				 .
	docker run -it --rm test-install-config:latest
