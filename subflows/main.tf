locals {
  namespace = "${var.namespace_prefix}.subflows"
}

resource "kestra_flow" "subflow_query_my_postgres_database" {
  flow_id   = "subflow-cloud-sql-airbyte-query"
  namespace = local.namespace
  content = templatefile("${path.module}/sub_query_my_postgres_database.yml.yml", {
    namespace = local.namespace
  })
}
