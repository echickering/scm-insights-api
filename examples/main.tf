module "prisma_access_api" {
  source         = "../modules/prisma_access_api"
  prisma_api_key = var.prisma_api_key
  prisma_api_url = var.prisma_api_url
  service_type   = var.service_type
  addr_type      = var.addr_type
  location       = var.location
}

output "egress_ips" {
  value = module.prisma_access_api.egress_ips
}
