resource "kestra_flow" "postgres_query" {
  flow_id   = var.flow_id
  namespace = var.namespace
  content = join("", [
    templatefile("${path.module}/tasks.yml", {
      flow_id                  = var.flow_id
      namespace                = var.namespace
      description              = var.description
      postgres-host            = var.postgres_host
      postgres-user            = var.postgres_user
      postgres-database        = var.postgres_database
      postgres-secret-password = var.postgres_password_secret
      sql-query                = var.sql_query
      show-result-in-logs      = var.show_result_in_logs
    }),
    var.trigger,
  ])
}
