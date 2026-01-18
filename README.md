# DevSecOps Project

This project demonstrates secure-by-default cloud infrastructure using:
- Terraform
- Jenkins
- Trivy (IaC scanning)
- AI-assisted remediation

Pipeline:
1. Checkout code
2. Scan Terraform using Trivy
3. AI-based remediation analysis
4. Re-scan after fixes
5. Terraform plan
