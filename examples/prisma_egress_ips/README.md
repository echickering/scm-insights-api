# **📂 `/examples/README.md`**

## 📌 Testing the Module Locally
To test a module, create a `terraform.tfvars` file in the `/examples/` directory.  
This file is **ignored by Git** to avoid exposing sensitive data.

### **🚀 Steps to Test**
1. **Copy the example `.tfvars` file:**
   ```sh
   cp examples/terraform.tfvars.example examples/terraform.tfvars
   ```
2. **Edit `terraform.tfvars` with your API key and preferred settings:**
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

## **🛠 Example: Using `prisma_egress_ips`**
```hcl
module "prisma_egress_ips" {
  source  = "echickering/api/prisma//modules/prisma_egress_ips"
  version = "1.0.0"
  prisma_api_key = var.prisma_api_key
  prisma_api_url = var.prisma_api_url
}
```

---

## **🔒 Example: AWS Security Group Update**
Use the retrieved egress IPs to dynamically configure an AWS security group:

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

## **🚀 Notes**
- You can modify `service_type`, `addr_type`, and `location` variables to filter the retrieved IPs.
- After testing, destroy the test infrastructure using:
  ```sh
  terraform destroy
  ```

🚀 **Now you're ready to integrate Prisma Access egress IPs into your cloud security policies!**  
Let me know if you need any tweaks! 🎯