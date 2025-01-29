# SCM Insights API - Prisma Access Egress IP Retriever

## Overview
This Terraform module retrieves **Prisma Access egress IPs** dynamically via the Prisma Access API. The output can be consumed by DevOps teams to automatically update cloud security configurations.

## Available Prisma Access API Endpoints
You can configure `prisma_api_url` with any of the following endpoints:
- `https://api.prod.datapath.prismaaccess.com/getPrismaAccessIP/v2`
- `https://api.prod2.datapath.prismaaccess.com/getPrismaAccessIP/v2`
- `https://api.prod4.datapath.prismaaccess.com/getPrismaAccessIP/v2`
- `https://api.prod6.datapath.prismaaccess.com/getPrismaAccessIP/v2`
- `https://api.lab.datapath.prismaaccess.com/getPrismaAccessIP/v2`

## Inputs
| Name             | Type   | Default  | Description |
|-----------------|--------|----------|-------------|
| `prisma_api_key` | `string` | N/A | API Key for Prisma Access authentication (sensitive) |
| `prisma_api_url` | `string` | `"https://api.prod.datapath.prismaaccess.com/getPrismaAccessIP/v2"` | Prisma Access API endpoint URL |
| `service_type`   | `string` | `"all"` | Prisma Access service type (all, remote_network, gp_gateway, etc.) |
| `addr_type`      | `string` | `"all"` | Address type (all, active, service_ip, etc.) |
| `location`       | `string` | `"all"` | Location scope (all or deployed) |

## Outputs
| Name        | Description |
|------------|-------------|
| `egress_ips` | List of egress IP addresses retrieved from Prisma Access |

## Usage & Examples
See the [`/examples` directory](examples/) for usage instructions and example Terraform configurations.