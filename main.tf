module "postgres" {
  source    = "./modules/postgres"
  namespace = var.mlflow_namespace

  db_username   = var.db_username
  db_password   = var.db_password
  database_name = var.database_name
}

module "mlflow" {
  source                 = "./modules/mlflow"
  namespace              = var.mlflow_namespace
  db_host                = module.postgres.db_host
  db_username            = var.db_username
  db_password            = var.db_password
  default_artifact_root  = var.mlflow_artifact_root
  docker_private_repo    = var.mlflow_docker_private_repo
  docker_registry_server = var.mlflow_docker_registry_server
  docker_auth_key        = var.mlflow_docker_auth_key

  service_type = var.mlflow_service_type
}




module "feast" {
  count = var.install_feast ? 1 : 0

  source    = "./modules/feast"
  namespace = var.feast_namespace

  feast_core_enabled           = true
  feast_online_serving_enabled = true
  feast_posgresql_enabled      = true
  feast_redis_enabled          = true

  feast_postgresql_password              = var.feast_postgresql_password
  feast_spark_operator_cluster_role_name = var.feast_spark_operator_cluster_role_name
}

module "seldon" {
  count     = var.install_seldon ? 1 : 0
  source    = "./modules/seldon"
  namespace = var.seldon_namespace
}


module "ambassador" {
  count     = var.ambassador_enabled ? 1 : 0
  source    = "./modules/ambassador"
  namespace = var.ambassador_namespace

  aws                 = var.aws
  tls_certificate_arn = var.tls_certificate_arn

  hostname                  = var.hostname
  tls                       = var.protocol == "https" ? true : false
  enable_ory_authentication = var.enable_ory_authentication
}



module "ory" {
  count              = var.enable_ory_authentication ? 1 : 0
  source             = "./modules/ory"
  namespace          = var.ory_namespace
  cookie_secret      = var.ory_kratos_cookie_secret
  kratos_db_password = var.ory_kratos_db_password
  oauth2_providers   = var.oauth2_providers

  hostname = var.hostname
  protocol = var.protocol

  enable_registration      = var.enable_registration_page
  enable_password_recovery = var.enable_password_recovery
  enable_verification      = var.enable_verification
  smtp_connection_uri      = var.smtp_connection_uri
  smtp_from_address        = var.smtp_from_address

  access_rules_path = var.access_rules_path
}
