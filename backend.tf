terraform {
  backend "remote" {
    organization = "db-test"

    workspaces {
      name = "Terraform"
    }
  }
}