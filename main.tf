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
