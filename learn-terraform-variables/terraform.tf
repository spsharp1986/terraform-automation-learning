# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {

  # Replace the placeholder with your HCP Terraform organisation.
  cloud {
    organization = "YOUR_HCP_ORGANIZATION"
    workspaces {
      name = "learn-terraform-variables"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.42.0"
    }
  }
  required_version = "~> 1.2"
}
