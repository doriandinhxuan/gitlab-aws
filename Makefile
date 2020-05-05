SHELL := /bin/bash

### Variables
ENV := "uat"
TF_STATE_BUCKET := "Your_S3_Bucket_Name"
TF_STATE_LOCK := "Your_DynamoDB_Table_Name"

init:
	cd terraform/ && terraform init -no-color -backend-config="bucket=$(TF_STATE_BUCKET)" -backend-config="key=environment/${ENV}/infrastructure.tfvars" -backend-config="dynamodb_table=$(TF_STATE_LOCK)" -backend=true -force-copy -get=true -lock=true -input=false
plan:
	cd terraform/ && terraform plan -no-color -var-file="environment/$(ENV)/infrastructure.tfvars"

apply:
	cd terraform/ && terraform apply -no-color --auto-approve -var-file="environment/$(ENV)/infrastructure.tfvars"

validate:
	cd terraform/ && terraform validate -no-color -var-file="environment/$(ENV)/infrastructure.tfvars"

refresh:
	cd terraform/ && terraform init -no-color -backend-config="bucket=$(TF_STATE_BUCKET)" -backend-config="key=environment/$(ENV)/infrastructure.tfstate" -backend-config="dynamodb_table=$(TF_STATE_LOCK)" -backend=true -force-copy -get=true -lock=true -input=false

destroy:
	cd terraform/ && terraform destroy -no-color --auto-approve -var-file="environment/$(ENV)/infrastructure.tfvars"
