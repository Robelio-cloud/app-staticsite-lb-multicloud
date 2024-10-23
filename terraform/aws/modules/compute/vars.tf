variable "ami" {
  type    = string
  default = "ami-0f409bae3775dc8e5"
}

variable "subnet1a_id" {
  type = string
}

variable "subnet1c_id" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "user_data" {
  type    = string
  default = <<EOF
#!/bin/bash
yum update -y
yum install -y httpd
echo "staticsite-lb-multi-cloud" > /var/www/html/index.html
service httpd restart
EOF
}

variable "elb_security_group_id" {
  type = string
}

variable "elb_name" {
  type    = string
  default = "staticsite-lb-aws"
}
