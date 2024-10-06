locals {
  namespace_kestra   = "prod.dbt.kestra_example"
  dbt_profile_kestra = "my_dbt_project"
}

module "trigger_dbt_run_kestra_example" {
  source             = "../../../modules/trigger_cron"
  cron_name          = "trigger_kestra_example_every_hour"
  cron_expression    = "0 * * * *" # Run every hour
  late_maximum_delay = "PT1H"
}

module "dbt_run_kestra_example" {
  source          = "../../../modules/dbt_run"
  flow_id         = "dbt_run_kestra_example"
  description     = "Run Kestra dbt example project"
  namespace       = local.namespace_kestra
  priority        = "low"
  github_repo_url = "https://github.com/kestra-io/dbt-example.git"
  git_branch      = "main"
  dbt_commands = [
    "dbt seed",
    "dbt build",
  ]
  dbt_profile_name = local.dbt_profile_kestra
  trigger          = module.trigger_dbt_run_kestra_example.trigger_content
}
