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
	rm -rf $(TERRAFORM_ZIP) && \
	cp $(TERRAFORM) $(HOME)/.local/bin

.PHONY: path 
path: 
	echo $(PATH)

.PHONY: install
install: $(TERRAFORM) path

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
	terraform destroy

.PHONY: clean
clean:
	rm -rf build