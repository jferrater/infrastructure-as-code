
# Check Operating System
OS := $(shell uname | tr '[:upper:]' '[:lower:]')

#
# Install Terraform
#
SHELL := /bin/bash
TERRAFORM_VERSION := $(shell cat terraform_version)
PATH := $(shell pwd)/bin/$(TERRAFORM_VERSION):$(PATH)

TERRAFORM_ZIP := terraform_$(TERRAFORM_VERSION)_$(OS)_amd64.zip
TERRAFORM := bin/$(TERRAFORM_VERSION)/terraform
$(TERRAFORM):
	mkdir -p bin/$(TERRAFORM_VERSION) && \
		cd bin/$(TERRAFORM_VERSION)   && \
		curl -O https://releases.hashicorp.com/terraform/$(TERRAFORM_VERSION)/$(TERRAFORM_ZIP) && \
		unzip $(TERRAFORM_ZIP) 	&& \
		cp terraform $(HOME)/.local/bin/terraform && \
		rm -rf $(TERRAFORM_ZIP) 

.PHONY: install
install: $(TERRAFORM)

.PHONY: init
init:
	terraform init

.PHONY: plan
plan:
	terraform plan

.PHONY: deploy
deploy:
	terraform apply

.PHONY: destroy
destroy:
	terraform destroy

.PHONY: clean
clean:
	rm -rf bin/$(TERRAFORM_VERSION)
	rm -rf $(HOME)/.local/bin/terraform