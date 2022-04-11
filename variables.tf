variable "name" {
  type = string
}

variable "github_oidc_arn" {
  type    = string
  default = ""
}

variable "github_repos" {
  type = list(string)
}