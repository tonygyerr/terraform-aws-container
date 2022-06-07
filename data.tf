data "aws_iam_policy_document" "empty" {
  count = var.enabled ? 1 : 0
}

data "aws_iam_policy_document" "resource_readonly_access" {
  count = var.enabled ? 1 : 0

  statement {
    sid    = "ReadonlyAccess"
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = var.principals_readonly_access
    }

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:DescribeImageScanFindings",
    ]
  }
}

data "aws_iam_policy_document" "resource_full_access" {
  count = var.enabled ? 1 : 0

  statement {
    sid    = "FullAccess"
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = var.principals_full_access
    }

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:DescribeImageScanFindings",
      "ecr:StartImageScan",
      "ecr:BatchDeleteImage",
      "ecr:SetRepositoryPolicy",
      "ecr:DeleteRepositoryPolicy",
      "ecr:DeleteRepository",
    ]
  }
}

data "aws_iam_policy_document" "resource" {
  count         = var.enabled ? 1 : 0
  source_json   = local.principals_readonly_access_non_empty ? join("", [data.aws_iam_policy_document.resource_readonly_access[0].json]) : join("", [data.aws_iam_policy_document.empty[0].json])
  override_json = local.principals_full_access_non_empty ? join("", [data.aws_iam_policy_document.resource_full_access[0].json]) : join("", [data.aws_iam_policy_document.empty[0].json])
}