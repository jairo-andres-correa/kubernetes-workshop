variable "project" { }

variable "credentials_file" { }

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-c"
}

variable "cidrs" { default = [] }

variable "environment" {
  type    = string
  default = "dev"
}

variable "machine_types" {
  type    = map
  default = {
    dev  = "f1-micro"
    test = "f1-micro"
    prod = "f1-micro"
  }
}

variable "lb-startup" {}

variable "lb-zones" {
  type = map
  default = {
    i1 = "us-central1-a"
    i2 = "us-central1-a"
    i3 = "us-central1-b"
  }
}