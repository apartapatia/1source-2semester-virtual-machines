terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.118.0"
    }
  }
}

locals {
  default_username   = "ubuntu"
  serial_port_enable = "1"
}

data "yandex_compute_image" "image" {
  family = var.image_family
}

resource "yandex_compute_instance" "this" {
  name                      = var.vm_name
  hostname                  = var.vm_name
  zone                      = var.zone
  platform_id               = var.platform_id
  allow_stopping_for_update = true

  resources {
    cores         = var.cores
    memory        = var.memory
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      type     = var.disk_type
      image_id = data.yandex_compute_image.image.id
      size     = var.disk_size
    }
  }

  network_interface {
    subnet_id          = var.subnet_id
    nat                = var.nat
    security_group_ids = [var.sg_id]
  }

  metadata = {
    serial-port-enable = local.serial_port_enable
    user-data = sensitive(templatefile("${path.module}/init/vm-install.yml",
      {
        USERNAME = local.default_username
        SSH_KEY  = var.ssh_key
    }))
  }
}