# --------------------------------
# Terraform configuration

terraform {
  required_version = "0.14.6"

  required_providers {
    aws         = "3.27.0"
    google      = "3.55.0"
    google-beta = "3.55.0"
  }

  backend "gcs" {
    prefix = "default/terraform"
  }
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_default_region
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_default_region
  zone    = "${var.gcp_default_region}-a"
}

provider "google-beta" {
  project = var.gcp_project_id
  region  = var.gcp_default_region
  zone    = "${var.gcp_default_region}-a"
}
