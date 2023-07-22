SHELL:=/usr/bin/env bash

export YC_OA_TOKEN := $(shell cat init.conf | grep oa_token | sed 's/oa_token = //')
export YC_CLOUD_ID := $(shell cat init.conf | grep cloud_id | sed 's/cloud_id = //')
export YC_FOLDER_ID := $(shell cat init.conf | grep folder_id | sed 's/folder_id = //')
export YC_ACCOUNT := $(shell cat init.conf | grep service_account | sed 's/service_account = //')
export TF_VAR_zone := $(shell cat init.conf | grep zone | sed 's/zone = //')
export SONAR_IP := $(shell cat ext_ip 2> /dev/null | grep sonar | sed 's/sonar[[:space:]]*//')
export NEXUS_IP := $(shell cat ext_ip 2> /dev/null | grep nexus | sed 's/nexus[[:space:]]*//')

prepare: cloud tf_init
deploy: tf_plan tf_apply
apps: get_ip play info

install:
	@source auto/install_env_app.sh

tester:
	@source auto/test.sh

cloud:
	@source $(HOME)/.bashrc && auto/init_cloud.sh

tf_init:
	@source auto/tf_provider_mirror.sh	
	@cd terraform && terraform init 

tf_plan: 
	@export YC_TOKEN=$(shell cat ./token) && cd terraform && terraform plan -out=terraform.tfplan

tf_apply: 
	@export YC_TOKEN=$(shell cat ./token) && cd terraform && terraform apply -auto-approve terraform.tfplan 

destroy: 
	@source $(HOME)/.bashrc && export YC_TOKEN=$(shell cat ./token) && source auto/destroy.sh

get_ip:
	@source auto/get_ip.sh

play:
	@source auto/prepare_ansible.sh
	@export ANSIBLE_HOST_KEY_CHECKING=False && cd playbook/ && ansible-playbook site.yml -i inventory/cicd/hosts.yml

info:
	@echo Your VM IP adresses:
	@echo ""
	@cd terraform && terraform output
