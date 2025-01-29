# Prisma Egress IP list API - Example Usage

## Overview
This Terraform module retrieves **Prisma Access egress IPs** dynamically via the Prisma Access API. The output can be consumed by DevOps teams to automatically update cloud security configurations.

## Available Prisma Access API Endpoints
You can configure `prisma_api_url` with any of the following endpoints:
- `https://api.prod.datapath.prismaaccess.com/getPrismaAccessIP/v2`
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

## Testing the Module Locally

### **Steps to Test**
1. **Copy the `example.tfvars` file to `terraform.tfvars` :**
   ```sh
   cp examples/prisma_egress_ip/example.tfvars examples/prisma_egress_ip/terraform.tfvars
   ```

2. **Edit `examples/prisma_egress_ip/terraform.tfvars` with your API key and preferred settings:**
   ```hcl
   prisma_api_key = "your_api_key_here"
   prisma_api_url = "https://api.prod.datapath.prismaaccess.com/getPrismaAccessIP/v2"
   service_type   = "all"
   addr_type      = "all"
   location       = "all"
   ```

3. **Run Terraform:**
   ```sh
   cd examples
   terraform init
   terraform plan
   terraform apply
   ```

---

## Example Terraform Usage
Once the module is applied, you can retrieve Prisma Access egress IPs and use them in your Terraform security configurations.

### **Basic Usage**
```hcl
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
```

---

## **Using Prisma Access IPs in an AWS Security Group**
### **Why Use This?**
Many organizations need to allow inbound connections from Prisma Access to their AWS workloads. Since Prisma Access dynamically assigns **egress IPs**, this module helps automate Security Group updates by retrieving the latest **Prisma Access egress IPs**.

### **How to Integrate with AWS Security Groups**
Once you apply the Terraform module, the **`egress_ips` output** provides a list of Prisma Access IP addresses. You can then use these IPs to allow secure access to AWS resources, such as:
- Web applications (HTTPS traffic)
- API endpoints
- Private services behind VPN/Direct Connect

### **Terraform Configuration**
Use the retrieved **egress IPs** dynamically in an **AWS Security Group**:

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

---

## **Using Prisma Access IPs in Other Cloud Platforms**
If you're using GCP or OCI, you can integrate the **egress IPs** in firewall rules:
- **GCP:** Use the IPs in `google_compute_firewall`
- **OCI:** Use the IPs in `oci_core_security_list`

### **Example: GCP Firewall Rule**
```hcl
resource "google_compute_firewall" "prisma_access" {
  name    = "prisma-access-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = module.prisma_access_api.egress_ips
}
```

### **Example: OCI Security List**
```hcl
resource "oci_core_security_list" "prisma_access" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id

  ingress_security_rules {
    protocol  = "6"
    source    = module.prisma_access_api.egress_ips[0]
    tcp_options {
      min = 443
      max = 443
    }
  }
}
```

---

## **Notes**
- You can modify `service_type`, `addr_type`, and `location` variables to filter the retrieved IPs.
- After testing, **destroy the test infrastructure** using:
   ```sh
   terraform destroy
   ```

🚀 **Now you're ready to integrate Prisma Access egress IPs into your cloud security policies!**