module "kestra_purge_db" {
  source                   = "../postgres_query"
  flow_id                  = var.flow_id
  namespace                = var.namespace
  description              = <<-EOT
  Flow to purge Kestra logs from database.
  Delete all logs lines older than ${var.retention_months} month(s).
  It just remove logs from UI, executions are still visible.
  EOT
  postgres_user            = "kestra"
  postgres_database        = "kestra"
  postgres_password_secret = var.postgres_password_secret
  postgres_host            = var.postgres_host
  show_result_in_logs      = false
  sql_query                = "DELETE FROM public.logs WHERE timestamp < NOW() - INTERVAL '${var.retention_months} month'"
  trigger                  = var.trigger
}
