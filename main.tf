resource "aws_iam_openid_connect_provider" "github" {
  count = var.github_oidc_arn == "" ? 1 : 0

  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1"
  ]
}

resource "aws_iam_role" "this" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data aws_iam_policy_document "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      identifiers = [var.github_oidc_arn == "" ? aws_iam_openid_connect_provider.github[0].arn : var.github_oidc_arn]
      type        = "Federated"
    }
    condition {
      test     = "StringLike"
      values   = var.github_repos
      variable = "token.actions.githubusercontent.com:sub"
    }
  }
}