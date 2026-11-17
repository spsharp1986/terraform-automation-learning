# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Terraform configuration
import {
  id = var.container_id
  to = docker_container.web
}
resource "docker_image" "nginx" {
  name = "nginx:latest"
}
