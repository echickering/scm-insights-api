# SCM Insights API - Terraform Modules

## Overview
This repository contains Terraform modules to interact with Prisma Access and SCM Insights.

## Available Modules
Each module is independent and can be used separately.

| Module Name | Description |
|-------------|------------|
| [`prisma_egress_ips`](modules/prisma_egress_ips) | Fetch Prisma Access egress IPs dynamically. |
| [`Application`](modules/Application) | Manage Prisma Access applications. |
| [`Incident`](modules/Incident) | Retrieve Prisma Access incident logs. |
| [`Location`](modules/Location) | Manage Prisma Access locations. |
| [`MobileUsers`](modules/MobileUsers) | Manage Prisma Access mobile users. |
| [`Sites`](modules/Sites) | Manage Prisma Access sites. |

## How to Use
Each module has a dedicated README inside its folder.

See the [`/examples'](examples/) directory for usage instructions and example Terraform configurations.