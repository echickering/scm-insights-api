# Terraform Prisma API

## Overview
This repository contains Terraform modules for interacting with Prisma Access APIs.  
Each **submodule** provides specific functionality, while the main module itself **does not perform any actions**.

---

## 📌 Available Submodules
Each module is independent and can be used separately.

| Module Name | Description |
|-------------|------------|
| [`prisma_egress_ips`](modules/prisma_egress_ips) | Fetch Prisma Access egress IPs dynamically. |
| [`Application`](modules/Application) | Manage Prisma Access applications. |
| [`Incident`](modules/Incident) | Retrieve Prisma Access incident logs. |
| [`Location`](modules/Location) | Manage Prisma Access locations. |
| [`MobileUsers`](modules/MobileUsers) | Manage Prisma Access mobile users. |
| [`Sites`](modules/Sites) | Manage Prisma Access sites. |

---

## 🚀 Usage
To use any of the submodules, reference them individually in your Terraform configuration.

### **Example: Using `prisma_egress_ips`**
```hcl
module "prisma_egress_ips" {
  source  = "echickering/api/prisma//modules/prisma_egress_ips"
  version = "1.0.1"
  prisma_api_key = var.prisma_api_key
  prisma_api_url = var.prisma_api_url
}
```

### **Example: Using `Application` Module**
```hcl
module "application" {
  source  = "echickering/api/prisma//modules/Application"
  version = "1.0.1"
}
```

---

## 📜 License
This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

## 📞 Support
For questions or issues, open a GitHub **Issue** or reach out at **echickerin@paloaltonetworks.com**.

---