resource "null_resource" "trigger_webhook" {
  triggers = {
    value = templatefile("${path.module}/triggers.yml", {
      webhook-name = var.webhook_name
      key          = var.key
    })
  }
}
