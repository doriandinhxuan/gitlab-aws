#    ___ ___  __  __ __  __  ___  _  _
#   / __/ _ \|  \/  |  \/  |/ _ \| \| |
#  | (_| (_) | |\/| | |\/| | (_) | .` |
#   \___\___/|_|  |_|_|  |_|\___/|_|\_|

variable "namespace" {
  type        = "string"
  default     = "gitlab"
  description = "Namespace (e.g. eg)"
}

variable "stage" {
  type        = "string"
  default     = "uat"
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
}

variable "name" {
  type        = "string"
  default     = "cloudbat"
  description = "Application or solution name (e.g. `app`)"
}

variable "region" {
  type        = "string"
  default     = "eu-west-1"
  description = "Region for VPC"
}

variable "availability_zones" {
  type        = "list"
  description = "Availability zones to use within region"
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `name`, `namespace`, `stage`, etc."
}

variable "attributes" {
  type        = "list"
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = "map"
  default = {
    Owner      = "Dorian Dinh Xuan"
    Created_by = "Terraform"
  }
  description = "Additional tags (e.g. `map('BusinessUnit`,`XYZ`)"
}
variable "enabled" {
  type        = "string"
  description = "Whether to create the resources. Set to `false` to prevent the module from creating any resources"
  default     = "true"
}

variable "private" {
  type        = "string"
  default     = "priv"
  description = "Type of subnets to create (`private`)"
}

variable "public" {
  type        = "string"
  default     = "pub"
  description = "Type of subnets to create (`public`)"
}

variable ssh_keypair_arn {
  default = ""
  description = "Secret ARN of ssh_keys from AWS secrets manager"
}

variable "lambda_function_name" {
  default = ""
}

#  __   _____  ___      __   ___ _   _ ___ _  _ ___ _____ ___
#  \ \ / / _ \/ __|    / /  / __| | | | _ ) \| | __|_   _/ __|
#   \ V /|  _/ (__    / /   \__ \ |_| | _ \ .` | _|  | | \__ \
#    \_/ |_|  \___|  /_/    |___/\___/|___/_|\_|___| |_| |___/

variable "vpc_cidr_block" {
  type        = "string"
  default     = ""
  description = "VPC CIDR block. See https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html for more details"
}

variable "pubec2_subnets" {
  default = []
}

variable "privec2_subnets" {
  default = []
}

variable "privdb_subnets" {
  default = []
}

#   ___   _   ___ _____ ___ ___  _  _
#  | _ ) /_\ / __|_   _|_ _/ _ \| \| |
#  | _ \/ _ \\__ \ | |  | | (_) | .` |
#  |___/_/ \_\___/ |_| |___\___/|_|\_|

variable bastion_private_ips {
  default = []
}

variable bastion_ami {
  default = ""
}

variable bastion_instance_type {
  default = ""
}

variable bastion_volume_size {
  default = ""
}

variable bastion_volume_snapshots_active {
  description = "Activate volume snapshots for bastion intances created in this env"
  default     = false
}

variable bastion_ingres_rules {
  default = []
}

variable bastion_egress_rules {
  default = []
}

#    ___   ___   _____   _        _     ___       __    ___   _   _   _  _   _  _   ___   ___
#   / __| |_ _| |_   _| | |      /_\   | _ )     / /   | _ \ | | | | | \| | | \| | | __| | _ \
#  | (_ |  | |    | |   | |__   / _ \  | _ \    / /    |   / | |_| | | .` | | .` | | _|  |   /
#   \___| |___|   |_|   |____| /_/ \_\ |___/   /_/     |_|_\  \___/  |_|\_| |_|\_| |___| |_|_\


variable gitlab_private_ips {
  default = []
}

variable "gitlab_hostname" {
  default = ""
}

variable gitlab_ami {
  default = ""
}

variable gitlab_instance_type {
  default = ""
}

variable gitlab_volume_size {
  default = ""
}

variable gitlab_volume_snapshots_active {
  description = "Activate volume snapshots for gitlab intances created in this env"
  default     = false
}

variable gitlab_ingres_rules {
  default = []
}

variable gitlab_egress_rules {
  default = []
}

##-----------------------------------------------------------------------------------------##
variable gitlab_runner_private_ips {
  default = []
}

variable "gitlab_runner_hostname" {
  default = ""
}

variable gitlab_runner_ami {
  default = ""
}

variable gitlab_runner_instance_type {
  default = ""
}

variable gitlab_runner_volume_size {
  default = ""
}

variable gitlab_runner_volume_snapshots_active {
  description = "Activate volume snapshots for gitlab_runner intances created in this env"
  default     = false
}

variable gitlab_runner_ingres_rules {
  default = []
}

variable gitlab_runner_egress_rules {
  default = []
}


variable "gitlab_runner_instance_role" {
  default = ""
}

variable "runners_executor" {
  default = "docker"
}

#     _     ___    ___
#    /_\   / __|  / __|
#   / _ \  \__ \ | (_ |
#  /_/ \_\ |___/  \___|

variable "health_check_type" {
  type        = "string"
  default     = "EC2"
  description = "Controls how health checking is done. Valid values are `EC2` or `ELB`"
}

variable "wait_for_capacity_timeout" {
  type        = "string"
  default     = "10m"
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior"
}

variable "max_size" {
  default     = 2
  description = "The maximum size of the autoscale group"
}

variable "min_size" {
  default     = 3
  description = "The minimum size of the autoscale group"
}

variable "cpu_utilization_high_threshold_percent" {
  type        = "string"
  default     = "80"
  description = "CPU utilization high threshold"
}

variable "cpu_utilization_low_threshold_percent" {
  type        = "string"
  default     = "20"
  description = "CPU utilization loq threshold"
}

#   ___      _     _____     _     ___     _     ___   ___
#  |   \    /_\   |_   _|   /_\   | _ )   /_\   / __| | __|
#  | |) |  / _ \    | |    / _ \  | _ \  / _ \  \__ \ | _|
#  |___/  /_/ \_\   |_|   /_/ \_\ |___/ /_/ \_\ |___/ |___|

variable depends_on {
  description = "This is a hacky workaround for getting Terraform to do module dependencies"
  default     = []
}
variable rds_tags {
  type    = "map"
  default = {}
}
variable sgroup_tags {
  type    = "map"
  default = {}
}
variable og_tags {
  type    = "map"
  default = {}
}
variable sg_tags {
  type    = "map"
  default = {}
}
variable deletion_protection {
  default = false
}

variable db_sg_subnet_ids {
  default = []
}

variable rds_secret_arn {
  default = ""
}
variable identifier {
  default = ""
}
variable database_name {
  default = ""
}
variable database_user {
  default = ""
}
variable database_password {
  default = ""
}
variable database_port {
  default = ""
}
variable engine {
  default = ""
}
variable engine_version {
  default = ""
}
variable instance_class {
  default = ""
}
variable allocated_storage {
  default = 30
}

variable "max_allocated_storage" {
  default = 50
}
variable storage_encrypted {
  default = false
}
variable multi_az {
  default = false
}
variable storage_type {
  default = ""
}
variable iops {
  default = ""
}
variable publicly_accessible {
  default = false
}
variable snapshot_identifier {
  default = ""
}
variable allow_major_version_upgrade {
  default = false
}
variable auto_minor_version_upgrade {
  default = false
}
variable major_engine_version {
  default = ""
}
variable family {
  default = ""
}
variable "parameter_group_name" {
  default     = ""
}
variable db_subnet_group_name {
  default = ""
}
variable db_subnet_group_description {
  default = ""
}
variable db_sg_name {
  default = ""
}
variable option_group_name {
  default = ""
}
variable apply_immediately {
  default = false
}
variable maintenance_window {
  default = ""
}
variable skip_final_snapshot {
  default = true
}
variable copy_tags_to_snapshot {
  default = true
}
variable backup_retention_period {
  default = 0
}
variable backup_window {
  default = ""
}

variable db_ingress_rules {
  default = []
}
variable db_egress_rules {
  default = []
}

