terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.118.0"
    }
  }
}

locals {
  any_protocol = "ANY"
  tcp_protocol = "TCP"
  all_ips      = ["0.0.0.0/0"]
  ssh_port     = 22
  http_port    = 80
  https_port   = 443
}

resource "yandex_vpc_security_group" "this" {
  name       = "${var.vpc_name}-sg"
  network_id = var.network_id

  egress {
    description    = "Allow all outbound traffic"
    protocol       = local.any_protocol
    v4_cidr_blocks = local.all_ips
  }

  ingress {
    description    = "Allow SSH access"
    protocol       = local.tcp_protocol
    port           = local.ssh_port
    v4_cidr_blocks = [var.trusted_ip_for_ssh]
  }

  ingress {
    description    = "Allow HTTP access"
    protocol       = local.tcp_protocol
    port           = local.http_port
    v4_cidr_blocks = local.all_ips
  }

  ingress {
    description    = "Allow HTTPS access"
    protocol       = local.tcp_protocol
    port           = local.https_port
    v4_cidr_blocks = local.all_ips
  }
}