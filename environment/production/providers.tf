provider "kestra" {
  # Kestra server URL (in this case we are running Kestra locally)
  url                  = "http://localhost:8080"
  username             = "demo"
  password             = "demo"
  keep_original_source = false # If set to true, diff is displayed badly in Terraform plan
}
