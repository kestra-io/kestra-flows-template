resource "random_shuffle" "default" {
  input        = range(0, 60, 10)
  result_count = 1
}

module "hourly_cron" {
  source             = "../trigger_cron"
  cron_expression    = "${random_shuffle.default.result[0]} * * * *"
  cron_name          = "hourly-trigger-at-minute-${random_shuffle.default.result[0]}"
  late_maximum_delay = "PT1H"
}
