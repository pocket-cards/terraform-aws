variable "project_name" {}
variable "profile" {}
variable "region" {
  default = "ap-northeast-1"
}
variable "domain_name" {}

variable "slack_url" {}
variable "translation_url" {}
variable "ipa_url" {}

variable "translation_api_key" {}
variable "ipa_api_key" {}

variable "github_token" {}
variable "github_organization" {}
variable "github_repo" {}
variable "github_branch" {}

variable "dns_name_servers" {
  default = []
}
