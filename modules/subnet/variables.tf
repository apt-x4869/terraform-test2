variable "region" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "vpc_name" {
    type = string
}

variable "subnet_name" {
    type = string
}

variable "subnet_type" {
  type = string
  default = "private"
}

variable "subnet" {
  type = list(string)
  default = []
}

variable "azs" {
  type = list(string)
  default = []
}

variable "route_table_id" {
  type = list(string)
}