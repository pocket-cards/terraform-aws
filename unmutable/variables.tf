
# ----------------------------------------
# Source Configs
# ----------------------------------------
variable "backend_repo" {}
variable "backend_owner" {}
variable "backend_branch" {
  default = "master"
}

variable "frontend_repo" {}
variable "frontend_owner" {}
variable "frontend_branch" {
  default = "master"
}

variable "devops_repo" {}
variable "devops_owner" {}
variable "devops_branch" {
  default = "master"
}

variable "mtn_repo" {}
variable "mtn_owner" {}
variable "mtn_branch" {
  default = "master"
}
