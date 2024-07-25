module "trigger_purge" {
  source             = "../../../../modules/trigger_cron"
  cron_expression    = "0 0 * * 0"
  cron_name          = "weekly_kestra_purge"
  late_maximum_delay = "PT1H"
}

module "purge_kestra_db" {
  source                         = "../../../../modules/purge_kestra"
  flow_id                        = "kestra_purge"
  namespace                      = "prod.automation"
  postgres_host                  = "34.41.114.214" # Cloud SQL: kestra-prod
  postgres_password_secret       = ""
  retention_months               = 2
  secret_name_cloud_sql_password = "kestra-database-credentials"
}
