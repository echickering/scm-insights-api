variable "prisma_api_key" {
  description = "API Key for Prisma Access API authentication"
  type        = string
  sensitive   = true
}

variable "prisma_api_url" {
  description = "Prisma Access API endpoint URL"
  type        = string
  default     = "https://api.prod6.datapath.prismaaccess.com/getPrismaAccessIP/v2"
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
