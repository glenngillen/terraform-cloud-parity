terraform {
  backend "remote" {}
}
variable "TFE_HOSTNAME" {
  description = "The Terraform Enterprise hostname to connect to. Defaults to app.terraform.io."
  default     = "app.terraform.io"
}

variable "TFE_TOKEN" {
  description = "The token used to authenticate with Terraform Enterprise"
}
provider "tfe" {
  hostname = var.TFE_HOSTNAME
  token    = var.TFE_TOKEN
}

resource "tfe_organization" "demo" {
  name  = "Compu-Global-Hyper-Mega-Net"
  email = "ggillen@hashicorp.com"
}

resource "tfe_workspace" "demo" {
  name         = "terraform-cloud-parity"
  organization = tfe_organization.demo.id
  queue_all_runs = false
}
resource "tfe_variable" "demo" {
  key          = "secret_key"
  value        = "not-actually-a-secret"
  category     = "terraform"
  workspace_id = tfe_workspace.demo.id
  sensitive    = true
}
resource "random_pet" "demo" {
  # keepers = {
  #   special_id = var.secret_key
  # }
}

# output "pet" {
#   value = random_pet.demo.id
# }