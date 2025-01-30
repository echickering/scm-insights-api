# Terraform Module: Prisma Egress IPs

## 📌 Overview
The **`prisma_egress_ips`** module retrieves **Prisma Access egress IPs** dynamically via the Prisma Access API.  
These IPs can be used to **update security groups, firewall rules, and network ACLs** dynamically.

---

## 🚀 Usage
To use this module, add the following to your Terraform configuration:

```hcl
module "prisma_egress_ips" {
  source  = "echickering/api/prisma//modules/prisma_egress_ips"
  version = "1.0.0"

  prisma_api_key = var.prisma_api_key
  prisma_api_url = var.prisma_api_url
}
```

---

## 🔧 Inputs
| Name            | Type   | Default  | Description |
|----------------|--------|----------|-------------|
| `prisma_api_key` | `string` | N/A | API Key for Prisma Access authentication (sensitive) |
| `prisma_api_url` | `string` | `"https://api.prod.datapath.prismaaccess.com/getPrismaAccessIP/v2"` | Prisma Access API endpoint URL |
| `service_type`  | `string` | `"all"` | Prisma Access service type (all, remote_network, gp_gateway, etc.) |
| `addr_type`     | `string` | `"all"` | Address type (all, active, service_ip, etc.) |
| `location`      | `string` | `"all"` | Location scope (all or deployed) |

---

## 🔄 Outputs
| Name        | Description |
|------------|-------------|
| `egress_ips` | List of egress IP addresses retrieved from Prisma Access |

---

## 🏗 Example: AWS Security Group Integration
You can dynamically configure **AWS Security Groups** to allow Prisma Access traffic:

```hcl
resource "aws_security_group" "prisma_access" {
  name        = "prisma-access-sg"
  description = "Allow traffic from Prisma Access egress IPs"

  dynamic "ingress" {
    for_each = module.prisma_egress_ips.egress_ips
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

---

## 📜 License
This project is licensed under the **MIT License**. See the [LICENSE](../../LICENSE) file for details.

---

## 📞 Support
For questions or issues, open a **GitHub Issue** or reach out at **echickerin@paloaltonetworks.com**.