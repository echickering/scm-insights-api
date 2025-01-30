module "prisma_egress_ips" {
  source         = "../../modules/prisma_egress_ips"
  prisma_api_key = var.prisma_api_key
  prisma_api_url = var.prisma_api_url
  service_type   = var.service_type
  addr_type      = var.addr_type
  location       = var.location
}

output "egress_ips" {
  value = module.prisma_egress_ips.egress_ips
}
