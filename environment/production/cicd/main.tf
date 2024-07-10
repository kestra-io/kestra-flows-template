resource "kestra_flow" "kestra_tf_apply_main" {
  flow_id   = "kestra_tf_apply_main"
  namespace = "prod.cicd"
  content   = file("${path.module}/tf_apply_kestra_tf.yml")
}
