module "ecr" {
  source    = "git::https://github.com/tonygyerr/terraform-aws-container.git"
  app_name  = var.app_name
  tags      = merge(map("Name", local.environment_name != local.tf_workspace ? "${local.tf_workspace}-${var.app_name}-ecr" : "${var.app_name}-ecr"), merge(var.tags, var.acn_tags))
}