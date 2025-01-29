terraform {
  required_providers {
    http = {
      source  = "hashicorp/http"
      version = "3.2.1"
    }
  }
}

provider "http" {}

variable "prisma_api_key" {
  description = "API Key for Prisma Access API authentication"
  type        = string
  sensitive   = true
}

variable "prisma_api_url" {
  description = "Prisma Access API endpoint URL"
  type        = string
  default     = "https://api.prod.datapath.prismaaccess.com/getPrismaAccessIP/v2"
}

variable "service_type" {
  description = "Prisma Access service type"
  type        = string
  default     = "all"
}

variable "addr_type" {
  description = "Address type (all, active, service_ip, etc.)"
  type        = string
  default     = "all"
}

variable "location" {
  description = "Prisma Access location scope"
  type        = string
  default     = "all"
}

data "http" "prisma_egress_ips" {
  url = var.prisma_api_url

  request_headers = {
    "header-api-key" = var.prisma_api_key
  }

  request_body = jsonencode({
    serviceType = var.service_type
    addrType    = var.addr_type
    location    = var.location
  })

  method = "POST"
}

locals {
  egress_ips = try(jsondecode(data.http.prisma_egress_ips.response_body).result[0].addresses, [])
}

output "egress_ips" {
  value = local.egress_ips
}