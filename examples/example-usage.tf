module "prisma_access_api" {
  source         = "../modules/prisma_access_api"
  prisma_api_key = "your_api_key"
}

output "egress_ips" {
  value = module.prisma_access_api.egress_ips
}
