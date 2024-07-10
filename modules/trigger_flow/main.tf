resource "null_resource" "trigger_cron" {
  triggers = {
    value = templatefile("${path.module}/triggers.yml", {
      parent-flow-id        = var.parent_flow_id
      parent-flow-namespace = var.parent_flow_namespace
    })
  }
}
