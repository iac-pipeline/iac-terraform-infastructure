provider "google" {
  project = "iac-pipeline-486415"
}


#suggested in the terraform docs provided by gcp
#https://github.com/terraform-google-modules/terraform-docs-samples/blob/main/storage/remote_terraform_backend_template/main.tf
resource "random_id" "default" {
  byte_length = 8
}

resource "google_storage_bucket" "default" {
    name    = "state-store"
    location  = "europe-west2"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true

  versioning {
    enabled = false
  }
}

resource "local_file" default {
    file_permission = "0644"
    filename = "${path.module}/backend.tf"
    content = <<-EOT
    terraform {
        backend "gcs" {
        bucket = "${google_storage_bucket.default.name}"
        }
    }
    EOT
}