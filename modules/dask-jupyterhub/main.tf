resource "helm_release" "dask-jupyterhub" {
  name      = "daskhub"
  namespace = var.namespace

  repository = "https://helm.dask.org"
  chart      = "daskhub"
  version    = "2021.7.2"

  // It takes some time to pull all the necessary images.
  timeout = 15 * 60

  values = [templatefile("${path.module}/values.yaml", {
    jupyterhub_secret = var.jupyterhub_secret
    daskgateway_secret = var.daskgateway_secret
    singleuser_profile_list = var.singleuser_profile_list
    singleuser_image_pull_secrets = var.singleuser_image_pull_secrets
    singleuser_image_pull_policy = var.singleuser_image_pull_policy
    singleuser_memory_guarantee = var.singleuser_memory_guarantee
    singleuser_storage_capacity = var.singleuser_storage_capacity
    singleuser_storage_mount_path = var.singleuser_storage_mount_path
    hub_allow_named_servers = var.hub_allow_named_servers
    admin_user = var.admin_user
    github_client_id = var.github_client_id
    github_client_secret = var.github_client_secret
    github_callback_url = var.github_callback_url
    github_organization = var.github_organization
  })]
}