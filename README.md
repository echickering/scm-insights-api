# SCM Insights API - Prisma Access Egress IP Retriever

## Overview
This Terraform module retrieves **Prisma Access egress IPs** dynamically via the Prisma Access API. The output can be consumed by DevOps teams to automatically update cloud security configurations.

## Usage

### Example
```hcl
module "prisma_access_api" {
  source         = "../modules/prisma_access_api"
  prisma_api_key = "your_api_key"
  prisma_api_url = "https://api.prod.datapath.prismaaccess.com/getPrismaAccessIP/v2"
}

output "egress_ips" {
  value = module.prisma_access_api.egress_ips
}
```

## Available Prisma Access API Endpoints

You can configure `prisma_api_url` with any of the following endpoints:
- `https://api.prod.datapath.prismaaccess.com/getPrismaAccessIP/v2`
- `https://api.prod2.datapath.prismaaccess.com/getPrismaAccessIP/v2`
- `https://api.prod4.datapath.prismaaccess.com/getPrismaAccessIP/v2`
- `https://api.prod6.datapath.prismaaccess.com/getPrismaAccessIP/v2`
- `https://api.lab.datapath.prismaaccess.com/getPrismaAccessIP/v2`

## Inputs

| Name            | Type   | Default  | Description |
|----------------|--------|----------|-------------|
| `prisma_api_key` | `string` | N/A | API Key for Prisma Access authentication (sensitive) |
| `prisma_api_url` | `string` | `"https://api.prod.datapath.prismaaccess.com/getPrismaAccessIP/v2"` | Prisma Access API endpoint URL |
| `service_type`  | `string` | `"all"` | Prisma Access service type (all, remote_network, gp_gateway, etc.) |
| `addr_type`     | `string` | `"all"` | Address type (all, active, service_ip, etc.) |
| `location`      | `string` | `"all"` | Location scope (all or deployed) |

## Outputs

| Name        | Description |
|------------|-------------|
| `egress_ips` | List of egress IP addresses retrieved from Prisma Access |

## How DevOps Can Use This Module

1. **Add this module to your Terraform configuration.**
2. **Consume the `egress_ips` output** in your CI/CD pipelines.
3. **Use the retrieved IPs** to update AWS Security Groups, GCP Firewall Rules, OCI Security Lists, or any other network policy.

### Example: AWS Security Group Update (DevOps Team)
```hcl
resource "aws_security_group" "prisma_access" {
  name        = "prisma-access-sg"
  description = "Allow traffic from Prisma Access egress IPs"

  dynamic "ingress" {
    for_each = module.prisma_access_api.egress_ips
    content {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

## Final Thoughts
✔ **This module only fetches Prisma Access egress IPs.**  
✔ **DevOps teams will use the output dynamically in their existing Terraform code.**  