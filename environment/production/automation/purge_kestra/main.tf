module "trigger_purge" {
  source             = "../../../../modules/trigger_cron"
  cron_expression    = "0 0 * * 0"
  cron_name          = "weekly_kestra_purge"
  late_maximum_delay = "PT1H"
}

# In this example we purge prod.automation namespace every 2 months
module "purge_kestra_automation_namespace" {
  source                   = "../../../../modules/purge_kestra_namespace"
  flow_id                  = "kestra_purge_automation"
  namespace                = "prod.automation"
  postgres_host            = "postgres:5432" # Localhost as running in docker-compose
  postgres_password_secret = "k3str4"        # See docker-compose.yml
  retention_months         = 2
  namespace_to_purge       = "prod.automation" # Namespace to purge
  trigger                  = module.trigger_purge.trigger_content
}

# In this example we purge prod.dbt namespace every month
module "purge_kestra_dbt_namespace" {
  source                   = "../../../../modules/purge_kestra_namespace"
  flow_id                  = "kestra_purge_dbt"
  namespace                = "prod.dbt"
  postgres_host            = "postgres:5432" # Localhost as running in docker-compose
  postgres_password_secret = "k3str4"        # See docker-compose.yml
  retention_months         = 1
  namespace_to_purge       = "prod.dbt" # Namespace to purge
  trigger                  = module.trigger_purge.trigger_content
}
