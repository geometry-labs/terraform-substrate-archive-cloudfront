SHELL := /bin/bash -euo pipefail
.PHONY: test all help

help: 								## Show help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

clear-cache:						## Clear the terragrunt and terraform caches
	find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {} \; && \
	find . -type d -name ".terraform" -prune -exec rm -rf {} \; && \
	find . -type f -name "*.tfstate*" -prune -exec rm -rf {} \;

test:								## Run tests
	go test ./test -v -timeout 15m
