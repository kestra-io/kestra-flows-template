resource "null_resource" "trigger_cron" {
  triggers = {
    value = templatefile("${path.module}/triggers.yml", {
      cron-name          = var.cron_name
      cron-expression    = var.cron_expression
      late-maximum-delay = var.late_maximum_delay
    })
  }
}
