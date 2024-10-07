resource "kestra_flow" "default" {
  flow_id   = "etl_python"
  namespace = "prod.automation"
  content = join("", [
    templatefile("${path.module}/tasks.yml", {})
  ])
}
