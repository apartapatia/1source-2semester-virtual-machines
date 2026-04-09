variable "vpc_name" {
  type        = string
}

variable "net_cidr" {
  type = map(object({
    name   = string
    prefix = string
  }))
}