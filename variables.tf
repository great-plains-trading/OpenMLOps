## General variables
variable "hostname" {
  description = "Hostname of the deployed cluster. Ex.: my-mlops.com"
}

variable "protocol" {
  default     = "http"
  description = "Preferred connection protocol. If using https, a valid ACM certificate must be provided under tls_certificate_arn. See documentation"
}

variable "install_locally" {
  default     = false
  description = "Whether to install on a local minikube"
}

## Daskhub

variable "jupyter_dummy_password" {
  default = ""
}

variable "install_jupyterhub" {
  default = true
}

variable "daskhub_namespace" {
  default = "jhub"
}

variable "oauth_github_enable" {
  description = "Defines whether the authentication will be handled by github oauth"
  default     = false
}

variable "oauth_github_client_id" {
  description = "github client id used on GitHubOAuthenticator"
  default     = ""
}
variable "oauth_github_client_secret" {
  description = "github secret used to authenticate with github"
  default     = ""
}

variable "oauth_github_admin_users" {
  description = "Github user names to allow as administrator"
  default     = []
}

variable "oauth_github_callback_url" {
  description = "The URL that people are redirected to after they authorize your GitHub App to act on their behalf"

}

variable "oauth_github_allowed_organization" {
  description = "List of Github organization to restrict access to the members"
}


locals {
  jhub_auth_config = {
    dummy = {
      password = var.jupyter_dummy_password
    }
    github = {
      clientId     = var.oauth_github_client_id
      clientSecret = var.oauth_github_client_secret
      callbackUrl  = var.oauth_github_callback_url
      orgWhiteList = var.oauth_github_allowed_organizations
    }
    scope = ["read:user"]
    admin = {
      users = var.oauth_github_admin_users
    }
  }
}

## MLFlow

variable "mlflow_namespace" {
  default = "mlflow"
}

variable "database_name" {
  default = "mlflow"
}
variable "db_password" {
  description = "Database password"
}

variable "db_username" {
  default = "postgres"
}

variable "mlflow_artifact_root" {
  default = "s3://mlops-model-artifact"
}

variable "mlflow_docker_private_repo" {
  description = "Whether the MLFlow's image comes from a private repository or not. If true, mlflow_docker_registry_server and mlflow_docker_auth_key will be required"
  type        = bool
  default     = false
}
variable "mlflow_docker_registry_server" {
  description = "Docker Registry Server where the MLFlow image should be found"
  type        = string
  default     = ""
}
variable "mlflow_docker_auth_key" {
  description = "Base64 encoded auth key for the registry server"
  type        = string
  default     = ""
}

variable "mlflow_service_type" {
  description = "Whether to expose the service publicly or internally"
  type        = string
  default     = "LoadBalancer"
}

## Feast
variable "install_feast" {
  default = false
}

variable "feast_namespace" {
  default = "feast"
}

variable "feast_postgresql_password" {
  default = "my-feast-password"
}

variable "feast_spark_operator_cluster_role_name" {
  default = "feast-spark-operator"
}

## Seldon

variable "install_seldon" {
  default = true
}

variable "seldon_namespace" {
  default = "seldon"
}
