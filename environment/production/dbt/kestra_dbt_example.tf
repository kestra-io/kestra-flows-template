locals {
  namespace_kestra   = "prod.dbt.kestra_example"
  dbt_profile_kestra = "my_dbt_project"
}

module "dbt_run_kestra_example" {
  source          = "../../../modules/dbt_run"
  flow_id         = "dbt_run_kestra_example"
  description     = "Run Kestra dbt example project"
  namespace       = local.namespace_kestra
  priority        = "low"
  github_repo_url = "https://github.com/kestra-io/dbt-example"
  git_branch      = "master"
  dbt_commands = [
    "dbt deps",
    "dbt build",
  ]
  dbt_profile_name = local.dbt_profile_kestra
  trigger          = module.trigger_dbt_run_jaffle_shop_orders.trigger_content
}
