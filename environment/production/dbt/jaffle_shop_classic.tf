locals {
  namespace = "prod.dbt.jaffle_shop"
}

######### Jaffle Shop Classic Orders #########

module "trigger_dbt_run_jaffle_shop_classic_orders" {
  source             = "../../../modules/trigger_cron"
  cron_name          = "trigger_dbt_jaffle_shope_orders_everyday_at_midnight"
  cron_expression    = "0 0 * * *" # Run every day at midnight
  late_maximum_delay = "PT1H"
}

module "dbt_run_jaffle_shop_classic_orders" {
  source          = "../../../modules/dbt_run"
  flow_id         = "dbt_run_jaffle_shop_classic_orders"
  description     = "Run orders model from dbt project jaffle-shop-classic"
  namespace       = local.namespace
  priority        = "high"
  github_repo_url = "https://github.com/dbt-labs/jaffle-shop-classic"
  git_branch      = "main"
  dbt_commands    = ["dbt build -s +orders"]
  trigger         = module.trigger_dbt_run_jaffle_shop_classic_orders.trigger_content
}

######### Jaffle Shop Classic Customers #########

module "trigger_dbt_run_jaffle_shop_classic_customers" {
  source = "../../../modules/trigger_cron_hourly_random"
}

module "dbt_run_jaffle_shop_classic_customers" {
  source          = "../../../modules/dbt_run"
  flow_id         = "dbt_run_jaffle_shop_classic_customers"
  description     = "Run customers model from dbt project jaffle-shop-classic"
  namespace       = local.namespace
  priority        = "high"
  github_repo_url = "https://github.com/dbt-labs/jaffle-shop-classic"
  git_branch      = "main"
  dbt_commands    = ["dbt build -s +customers"]
  trigger         = module.trigger_dbt_run_jaffle_shop_classic_customers.trigger_content
}
