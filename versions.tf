terraform {
  required_version = ">= 0.13"
  required_providers {
    http = {
      source = "hashicorp/http"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.4.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.7.1"
    }
    local = {
      source = "hashicorp/local"
    }
    null = {
      source = "hashicorp/null"
    }
    random = {
      source = "hashicorp/random"
    }
    template = {
      source = "hashicorp/template"
    }
  }
}
