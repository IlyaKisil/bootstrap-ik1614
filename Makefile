#################################################################################
# This Makefile is self-documented
# Use ## before target to provide a description
#################################################################################
.DEFAULT_GOAL := help

SHELL = /bin/bash

.PHONY: update-submodules test-install-profile test-install-config

## Recursively udpate all existing submodules
update-submodules:
	git submodule update --init --recursive --remote

## Build docker image with installed profile
test-install-profile:
	cd ..
	docker build \
		-t test-install-profile:latest \
		-f tests/test-install-profile.dockerfile \
		.
	docker run \
		-it \
		--rm \
		--name dotbot-install-profile \
		test-install-profile:latest

## Build docker image with installed stand alone configs
test-install-config:
	cd ..
	docker build -t test-install-config:latest \
				 -f tests/test-install-config.dockerfile \
				 .
	docker run \
		-it \
		--rm \
		--name dotbot-install-config \
		test-install-config:latest


#################################################################################
# For self-documenting of Makefile: use '##' before target to provide a description
#
# References:
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
# https://github.com/drivendata/cookiecutter-data-science/blob/master/%7B%7B%20cookiecutter.repo_name%20%7D%7D/Makefile
#
# sed script explained:
# /^##/:
# 	* save line in hold space
# 	* purge line
# 	* Loop:
# 		* append newline + line to hold space
# 		* go to next line
# 		* if line starts with doc comment, strip comment character off and loop
# 	* remove target prerequisites
# 	* append hold space (+ newline) to line
# 	* replace newline plus comments by `---`
# 	* print line
# Separate expressions are necessary because labels cannot be delimited by
# semicolon; see <http://stackoverflow.com/a/11799865/1968>
#
#################################################################################
.PHONY: help

## Show this message
help:
	@echo "$$(tput bold)Available rules:$$(tput sgr0)"
	@echo
	@sed -n -e "/^## / { \
		h; \
		s/.*//; \
		:doc" \
		-e "H; \
		n; \
		s/^## //; \
		t doc" \
		-e "s/:.*//; \
		G; \
		s/\\n## /---/; \
		s/\\n/ /g; \
		p; \
	}" ${MAKEFILE_LIST} \
	| LC_ALL='C' sort --ignore-case \
	| awk -F '---' \
		-v ncol=$$(tput cols) \
		-v indent=25 \
		-v col_on="$$(tput setaf 6)" \
		-v col_off="$$(tput sgr0)" \
	'{ \
		printf "%s%*s%s ", col_on, -indent, $$1, col_off; \
		n = split($$2, words, " "); \
		line_length = ncol - indent; \
		for (i = 1; i <= n; i++) { \
			line_length -= length(words[i]) + 1; \
			if (line_length <= 0) { \
				line_length = ncol - indent - length(words[i]) - 1; \
				printf "\n%*s ", -indent, " "; \
			} \
			printf "%s ", words[i]; \
		} \
		printf "\n"; \
	}' \
	| more $(shell test $(shell uname) = Darwin && echo '--no-init --raw-control-chars')
