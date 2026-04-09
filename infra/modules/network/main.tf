terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.118.0"
    }
  }
}

resource "yandex_vpc_network" "this" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "this" {
  for_each       = var.net_cidr
  name           = each.value.name
  zone           = each.key
  v4_cidr_blocks = [each.value.prefix]
  network_id     = yandex_vpc_network.this.id
}
