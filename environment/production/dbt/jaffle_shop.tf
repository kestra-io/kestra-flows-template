locals {
  namespace_jaffle       = "prod.dbt"
  dbt_profile_jaffle     = "jaffle_shop"
  github_repo_url_jaffle = "https://github.com/dbt-labs/jaffle_shop_duckdb.git"
}

######### Jaffle Shop Classic Orders #########

module "trigger_dbt_run_jaffle_shop_orders" {
  source             = "../../../modules/trigger_cron"
  cron_name          = "trigger_dbt_jaffle_shope_orders_everyday_at_midnight"
  cron_expression    = "0 0 * * *" # Run every day at midnight
  late_maximum_delay = "PT1H"
}

module "dbt_run_jaffle_shop_orders" {
  source          = "../../../modules/dbt_run"
  flow_id         = "dbt_run_jaffle_shop_orders"
  description     = "Run orders model from dbt project jaffle-shop-classic"
  namespace       = local.namespace_jaffle
  priority        = "high"
  github_repo_url = local.github_repo_url_jaffle
  git_branch      = "duckdb"
  dbt_commands = [
    "dbt seed",
    "dbt run -s +orders",
  ]
  dbt_profile_name = local.dbt_profile_jaffle
  trigger          = module.trigger_dbt_run_jaffle_shop_orders.trigger_content
}

######### Jaffle Shop Classic Customers #########

module "trigger_dbt_run_jaffle_shop_customers" {
  source = "../../../modules/trigger_cron_hourly_random"
}

module "dbt_run_jaffle_shop_customers" {
  source          = "../../../modules/dbt_run"
  flow_id         = "dbt_run_jaffle_shop_customers"
  description     = "Run customers model from dbt project jaffle-shop-classic"
  namespace       = local.namespace_jaffle
  priority        = "high"
  github_repo_url = local.github_repo_url_jaffle
  git_branch      = "duckdb"
  dbt_commands = [
    "dbt seed",
    "dbt run -s +customers",
  ]
  dbt_profile_name = local.dbt_profile_jaffle
  trigger          = module.trigger_dbt_run_jaffle_shop_customers.trigger_content
}
