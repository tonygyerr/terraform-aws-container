resource "aws_ecr_repository" "name" {
  for_each             = toset(var.enabled ? local.image_names : [])
  name                 = each.value
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_images_on_push
  }

  tags = merge(map("Name", local.environment_name != local.tf_workspace ? "${local.tf_workspace}-${var.app_name}-ecr" : "${var.app_name}-ecr"), merge(var.tags, var. acn_tags))
}

resource "aws_ecr_lifecycle_policy" "name" {
  for_each   = toset(var.enabled && var.enable_lifecycle_policy ? local.image_names : [])
  repository = aws_ecr_repository.name[each.value].name

  policy = jsonencode({
    rules = concat(local.protected_tag_rules, local.untagged_image_rule, local.remove_old_image_rule)
  })
}

resource "aws_ecr_repository_policy" "name" {
  for_each   = toset(local.ecr_need_policy && var.enabled ? local.image_names : [])
  repository = aws_ecr_repository.name[each.value].name
  policy     = join("", data.aws_iam_policy_document.resource.*.json)
}
