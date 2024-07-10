resource "kestra_flow" "slack_alerting" {
  flow_id   = var.flow_id
  namespace = "${var.namespace_prefix}.monitoring"
  content = join("", [
    templatefile("${path.module}/tasks.yml", {
      namespace-prefix  = var.namespace_prefix
      silent-flows      = var.silent_flows
      slack-webhook-url = var.slack_webhook_url
      slack-channel     = var.slack_channel
    })
  ])
}
