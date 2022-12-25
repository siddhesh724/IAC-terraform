terraform {
  cloud {
    organization = "hashicorp-siddhesh"

    workspaces {
      name = "IAC-terraform"
    }
  }
}