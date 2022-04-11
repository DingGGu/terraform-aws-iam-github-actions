# Github Actions with AWS IAM

https://github.com/aws-actions/configure-aws-credentials

A Terraform module for Github Actions with AWS IAM

## Usage

```terraform
module "sample" {
  source = "github.com/DingGGu/terraform-aws-iam-github-actions"

  name         = "sample.iam.github"
  github_repos = [
    "repo:ORGANIZATION/REPOSITORY:*",
  ]
}

resource "aws_iam_role_policy" "sample-policy1" {
  role   = module.sample.iam_role_name
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}
```

or re-use Github OIDC Provider

```terraform

```

```terraform
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

module "sample2" {
  source = "github.com/DingGGu/terraform-aws-iam-github-actions"
  
  github_oidc_arn = aws_iam_openid_connect_provider.github.arn
  name            = "sample2.iam.github"

  github_repos = [
    "repo:ORGANIZATION/REPOSITORY:*",
  ]
}

resource "aws_iam_role_policy" "sample-policy2" {
  role   = module.sample2.iam_role_name
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}


module "sample3" {
  source = "github.com/DingGGu/terraform-aws-iam-github-actions"

  github_oidc_arn = aws_iam_openid_connect_provider.github.arn
  name            = "sample2.iam.github"

  github_repos = [
    "repo:ORGANIZATION/REPOSITORY:*",
  ]
}

resource "aws_iam_role_policy" "sample-policy3" {
  role   = module.sample3.iam_role_name
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}
```
