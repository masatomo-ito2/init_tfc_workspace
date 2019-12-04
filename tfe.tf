# Use TFE provider to init workspace and generate general variables

provider "tfe" {
}

# Variables (set these in .tfvars)
variable "workspace_name" {}
variable "org_name" {}
variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}
variable "tfe_token" {}
variable "vault_token" {}

# create new workspace
resource "tfe_workspace" "ws" {
	name = var.workspace_name
	organization = var.org_name
}

resource "tfe_variable" "aws_access_key_id" {
	key = "AWS_ACCESS_KEY_ID"
	value = var.aws_access_key_id
	category = "env"
	sensitive = false
	workspace_id = tfe_workspace.ws.id
}

resource "tfe_variable" "aws_secret_access_key" {
	key = "AWS_SECRET_ACCESS_KEY"
	value = var.aws_secret_access_key
	category = "env"
	sensitive = true
	workspace_id = tfe_workspace.ws.id
}

resource "tfe_variable" "confirm_destroy" {
	key = "CONFIRM_DESTROY"
	value = 1
	category = "env"
	sensitive = false
	workspace_id = tfe_workspace.ws.id
}

resource "tfe_variable" "vault_token" {
	key = "VAULT_TOKEN"
	value = var.vault_token
	category = "env"
	sensitive = true
	workspace_id = tfe_workspace.ws.id
}

resource "tfe_variable" "tfe_token" {
	key = "TFE_TOKEN"
	value = var.tfe_token
	category = "env"
	sensitive = true
	workspace_id = tfe_workspace.ws.id
}
