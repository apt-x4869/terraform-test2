variable "region" {
    type = string
}

variable "existing_vpc" {
    type = bool
    default = false
}

variable "vpc_id" {
    type = string
    default = ""
}

variable "vpc_name" {
    type = string
}

variable "cidr_block" {
    type = string
}


variable "secondary_cidr_blocks" {
  description = "List of secondary CIDR blocks to associate with the VPC to extend the IP Address pool"
  type        = list(string)
  default     = []
}

variable "azs" {
  description = "List of Available Availible Zone in region"
  type        = list(string)
  default     = []
}

variable "public_subnet" {
  description = "List of valid public subnet ranges to create"
  type        = list(string)
  default     = []
}

variable "private_subnet" {
  description = "List of valid private subnet ranges to create"
  type        = list(string)
  default     = []
}

variable "k8s_subnet" {
  description = "List of valid private subnet ranges to create"
  type        = list(string)
  default     = []
}