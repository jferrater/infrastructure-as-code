.PHONY: help
help:
	echo "Usage:"
	echo ""
	echo "$$ make install"
	echo "$$ make init"
	echo "$$ make plan"
	echo "$$ make deploy"
	echo "$$ make destroy"
	echo "$$ make clean"

SHELL := /bin/bash

ENVIRONMENT ?= "dev"
OS := $(shell uname | tr '[:upper:]' '[:lower:]')
TERRAFORM_VERSION := $(shell cat terraform_version)
TERRAFORM_ZIP := terraform_$(TERRAFORM_VERSION)_$(OS)_amd64.zip

export PATH := $(shell pwd)/build/$(TERRAFORM_VERSION):$(PATH)

TERRAFORM := build/$(TERRAFORM_VERSION)/terraform
$(TERRAFORM):
	mkdir -p build/$(TERRAFORM_VERSION) && \
	cd build/$(TERRAFORM_VERSION) && \
	curl -O https://releases.hashicorp.com/terraform/$(TERRAFORM_VERSION)/$(TERRAFORM_ZIP) && \
	unzip $(TERRAFORM_ZIP) && \
	rm -rf $(TERRAFORM_ZIP)

.PHONY: install
install: $(TERRAFORM)

.PHONY: init
init: install
	cd environments/$(ENVIRONMENT) && \
		terraform init

.PHONY: plan
plan: init
	cd environments/$(ENVIRONMENT) && \
		terraform plan

.PHONY: deploy
deploy:
	cd environments/$(ENVIRONMENT) && \
		terraform apply

.PHONY: destroy
	cd environments/$(ENVIRONMENT) && \
		terraform destroy

.PHONY: clean
clean:
	rm -rf build