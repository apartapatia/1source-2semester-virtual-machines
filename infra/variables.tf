variable "vpc_name" {
  type    = string
  default = "infra-network"
}

variable "net_cidr" {
  type = map(object({
    name   = string
    prefix = string
  }))

  default = {
    "ru-central1-a" = { name = "infra-subnet-a", prefix = "10.129.1.0/24" }
    "ru-central1-b" = { name = "infra-subnet-b", prefix = "10.130.1.0/24" }
    "ru-central1-d" = { name = "infra-subnet-d", prefix = "10.131.1.0/24" }
  }
}

variable "vm_name" {
  type    = string
  default = "vm-kittygram"
}

variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "zone" {
  type    = string
  default = "ru-central1-a"

  validation {
    condition     = contains(["ru-central1-a", "ru-central1-b", "ru-central1-d"], var.zone)
    error_message = "Valid values for zone are: ru-central1-a, ru-central1-b, ru-central1-d."
  }
}

variable "image_family" {
  type    = string
  default = "ubuntu-2404-lts"
}

variable "platform_id" {
  type    = string
  default = "standard-v3"
}

variable "cores" {
  type    = number
  default = 2
  validation {
    condition     = var.cores >= 2
    error_message = "Number of cores must be at least 2."
  }
}

variable "memory" {
  description = "Amount of RAM in GB"
  type        = number
  default     = 2
  validation {
    condition     = var.memory >= 1
    error_message = "Memory must be at least 1 GB."
  }
}

variable "disk_type" {
  type    = string
  default = "network-hdd"
}

variable "disk_size" {
  type    = number
  default = 20
  validation {
    condition     = var.disk_size >= 10
    error_message = "Disk size must be at least 10 GB."
  }
}

variable "nat" {
  type    = bool
  default = true
}

variable "core_fraction" {
  description = "Baseline CPU performance as a fraction of a core (1-100)"
  type        = number
  default     = 20
  validation {
    condition     = var.core_fraction > 0 && var.core_fraction <= 100
    error_message = "Core fraction must be between 1 and 100."
  }
}

variable "trusted_ip_for_ssh" {
  description = "IP list for available ssh connection"
  type        = string
  default     = "0.0.0.0/0"
}