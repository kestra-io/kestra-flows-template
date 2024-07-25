module "trigger_purge" {
  source             = "../../../../modules/trigger_cron"
  cron_expression    = "0 0 * * 0"
  cron_name          = "weekly_kestra_purge"
  late_maximum_delay = "PT1H"
}

module "purge_kestra_db" {
  source                   = "../../../../modules/purge_kestra"
  flow_id                  = "kestra_purge"
  namespace                = "prod.automation"
  postgres_host            = "localhost" # Localhost as running in docker-compose
  postgres_password_secret = "k3str4"    # See docker-compose.yml
  retention_months         = 2
}
