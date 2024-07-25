resource "kestra_namespace_file" "default" {
  namespace = "prod.automation"
  filename  = "transform.py"
  content   = file("${path.module}/transform.py")
}

resource "kestra_flow" "default" {
  flow_id   = "etl_python"
  namespace = "prod.automation"
  content = join("", [
    templatefile("${path.module}/tasks.yml", {
      python-file-uri = kestra_namespace_file.default.id
    })
  ])
}
