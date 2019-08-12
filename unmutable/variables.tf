
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

variable "automation_repo" {}
variable "automation_owner" {}
variable "automation_branch" {
  default = "master"
}

