variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet1a_cidr" {
  type    = string
  default = "10.0.5.0/24"
}

variable "subnet1c_cidr" {
  type    = string
  default = "10.0.6.0/24"
}

variable "az1" {
  type    = string
  default = "us-east-1a"
}

variable "az2" {
  type    = string
  default = "us-east-1c"
}
