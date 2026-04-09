data "yandex_lockbox_secret_version" "my_secret" {
  secret_id = "e6qigfb45t7qhf9ucv65"
}

locals {
  secrets = { for entry in data.yandex_lockbox_secret_version.my_secret.entries : entry.key => entry.text_value }

  yc_ssh_pub = local.secrets["yc_ssh_pub"]
}
