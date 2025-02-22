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