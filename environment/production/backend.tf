terraform {
  required_providers {
    kestra = {
      source  = "kestra-io/kestra"
      version = "~> 0.17.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
  required_version = ">= 1.6"
}
