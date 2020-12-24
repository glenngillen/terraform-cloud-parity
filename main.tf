terraform {
  backend "remote" {}
}
variable "tfe_hostname" {
  description = "The Terraform Enterprise hostname to connect to. Defaults to app.terraform.io."
  default     = "app.terraform.io"
}

variable "tfe_token" {
  description = "The token used to authenticate with Terraform Enterprise"
}
provider "tfe" {
  hostname = var.tfe_hostname
  token    = var.tfe_token
}
# variable "secret_key" {}

resource "tfe_organization" "demo" {
  name  = "Compu-Global-Hyper-Mega-Net"
  email = "ggillen@hashicorp.com"
}

resource "tfe_workspace" "demo" {
  name         = "terraform-cloud-parity"
  organization = tfe_organization.demo.id
}
resource "tfe_variable" "demo" {
  key          = "secret_key"
  value        = "not-actually-a-secret"
  category     = "terraform"
  workspace_id = tfe_workspace.demo.id
  description  = "demonstrating sensitive variable and import issues"
}
resource "random_pet" "demo" {
  # keepers = {
  #   special_id = var.secret_key
  # }
}

output "pet" {
  value = random_pet.demo.id
}