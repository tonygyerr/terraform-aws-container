# variable "namespace" {
#   type        = string
#   description = "Namespace (e.g. `eg` or `cp`)"
#   default     = ""
# }

# variable "environment" {
#   type        = string
#   default     = ""
#   description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
# }

# variable "stage" {
#   type        = string
#   description = "Stage (e.g. `prod`, `dev`, `staging`)"
#   default     = ""
# }

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `name`, `namespace`, `stage`, etc."
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `policy` or `role`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`)"
}

variable "enabled" {
  type        = bool
  description = "Set to false to prevent the module from creating any resources"
  default     = true
}

variable "use_fullname" {
  type        = bool
  default     = true
  description = "Set 'true' to use `namespace-stage-name` for ecr repository name, else `name`"
}

variable "principals_full_access" {
  type        = list(string)
  description = "Principal ARNs to provide with full access to the ECR"
  default     = []
}

variable "principals_readonly_access" {
  type        = list(string)
  description = "Principal ARNs to provide with readonly access to the ECR"
  default     = []
}

variable "scan_images_on_push" {
  type        = bool
  description = "Indicates whether images are scanned after being pushed to the repository (true) or not (false)"
  default     = false
}

variable "max_image_count" {
  type        = number
  description = "How many Docker Image versions AWS ECR will store"
  default     = 500
}

variable "regex_replace_chars" {
  type        = string
  default     = "/[^a-z/A-Z_0-9-]/"
  description = "Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`. By default only letters, digits, dash, slash, and underscore are allowed, all other chars are removed"
}

variable "image_names" {
  type        = list(string)
  default     = []
  description = "List of Docker local image names, used as repository names for AWS ECR "
}

variable "image_tag_mutability" {
  type        = string
  default     = "MUTABLE"
  description = "The tag mutability setting for the repository. Must be one of: `MUTABLE` or `IMMUTABLE`"
}

variable "enable_lifecycle_policy" {
  type        = bool
  description = "Set to false to prevent the module from adding any lifecycle policies to any repositories"
  default     = true
}

variable "protected_tags" {
  type        = set(string)
  description = "Name of image tags prefixes that should not be destroyed. Useful if you tag images with names like `dev`, `staging`, and `prod`"
  default     = []
}

variable "app_name" {
  type        = string
  description = "Application Name"
  default     = ""
}

variable "vpc_config" {
  description = "configuration option for vpc"
  type        = map(string)
  default     = {}
}

variable "deploy_env_map" {
  type = map
  default = {
    dev = "develop"
    test = "test"
    prod = "prod"
  }
}

variable "acn_tags" {
  type        = map(string)
  description = "optional tags"

  default = {}
}

variable "profile" {
  description = "Enter name of profile"
  default     = ""
}

variable "aws_region" {
  description = "ec2 region for the vpc"
  default     = ""
}