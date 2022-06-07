variable "app_name" {
  type        = string
  description = "Application Name"
  default     = ""
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`)"
}

variable "vpc_config" {
  description = "configuration option for vpc"
  type        = map(string)
  default     = {}
}

variable "acn_tags" {
  type        = map(string)
  description = "optional tags"

  default = {}
}

variable "deploy_env_map" {
  type = map
  default = {
    dev = "develop"
    test = "test"
    prod = "prod"
  }
}

variable "profile" {
  description = "Enter name of profile"
  default     = ""
}

variable "aws_region" {
  description = "ec2 region for the vpc"
  default     = ""
}