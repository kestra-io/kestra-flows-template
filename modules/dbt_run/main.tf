resource "kestra_flow" "dbt_run" {
  flow_id   = var.flow_id
  namespace = var.namespace
  content = join("", [
    yamlencode({
      id          = var.flow_id
      namespace   = var.namespace
      description = var.description
      disabled    = var.disabled
    }),
    templatefile("${path.module}/tasks.yml", {
      labels          = var.labels
      github-repo-url = var.github_repo_url
      git-branch      = var.git_branch
      dbt-commands    = var.dbt_commands
      dbt-profile     = var.dbt_profile_name
      dbt-max-attempt = var.dbt_max_retry_attempt
    }),
    var.trigger,
  ])
}
