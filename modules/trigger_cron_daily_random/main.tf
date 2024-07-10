resource "random_shuffle" "default" {
  input        = [0, 1, 2, 3, 4, 5]
  result_count = 1
}

module "daily_cron" {
  source             = "../trigger_cron"
  cron_expression    = "30 ${random_shuffle.default.result[0]} * * *"
  cron_name          = "daily-trigger-at-hour-${random_shuffle.default.result[0]}-30-AM"
  late_maximum_delay = "PT1H"
}
