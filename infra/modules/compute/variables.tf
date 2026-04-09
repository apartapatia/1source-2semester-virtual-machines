variable "vm_name" {
  type        = string
}

variable "zone" {
  type        = string
}

variable "platform_id" {
  type        = string
}

variable "cores" {
  type        = number
}

variable "memory" {
  type        = number
}

variable "core_fraction" {
  type        = number
}

variable "disk_type" {
  type        = string
}

variable "disk_size" {
  type        = number
}

variable "image_family" {
  type        = string
}

variable "subnet_id" {
  type        = string
}

variable "nat" {
  type        = bool
}

variable "sg_id" {
  type        = string
}

variable "ssh_key" {
  type        = string
  sensitive   = true
}