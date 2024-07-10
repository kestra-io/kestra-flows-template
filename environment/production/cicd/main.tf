resource "kestra_flow" "kestra_tf_apply_main" {
  flow_id   = "kestra_tf_apply_main"
  namespace = "prod.cicd"
  content   = file("${path.module}/terraform_apply_flows.yml")
}
