# SCM Insights API - Example Usage

## Overview
This directory contains example Terraform configurations to demonstrate how to use the **SCM Insights API** module.

---

## Testing the Module Locally

### **Steps to Test**
1. **Copy the `example.tfvars` file to `terraform.tfvars` :**
   ```sh
   cp examples/example.tfvars examples/terraform.tfvars
   ```

2. **Edit `examples/terraform.tfvars` with your API key and preferred settings:**
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
module "prisma_access_api" {
  source         = "../modules/prisma_access_api"
  prisma_api_key = var.prisma_api_key
  prisma_api_url = var.prisma_api_url
}

output "egress_ips" {
  value = module.prisma_access_api.egress_ips
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
- The `.gitignore` file ensures `terraform.tfvars` is **not committed** to prevent accidental exposure of secrets.
- You can modify `service_type`, `addr_type`, and `location` variables to filter the retrieved IPs.
- After testing, **destroy the test infrastructure** using:
   ```sh
   terraform destroy
   ```

🚀 **Now you're ready to integrate Prisma Access egress IPs into your cloud security policies!**
