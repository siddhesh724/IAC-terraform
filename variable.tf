variable "vpc" {
  type        = string
  description = "enter vpc cidr value"
  default     = "10.100.0.0/16"
}

variable "pub_subnet_cidr" {
  type        = list(string)
  description = "enter Subnet CIDR value"
  default     = ["10.100.1.0/24", "10.100.2.0/24", "10.100.3.0/24", "10.100.4.0/24"]
}

variable "private_subnet_cidr" {
  type        = list(string)
  description = "enter Subnet CIDR value"
  default     = ["10.100.10.0/24", "10.100.11.0/24", "10.100.12.0/24", "10.100.13.0/24"]
}