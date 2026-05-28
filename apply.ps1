# Quick apply script for evaluation/demo
# Usage: Open PowerShell in repo root and run: .\apply.ps1

param(
  [switch]$Destroy
)

if ($Destroy) {
  Write-Host "Running terraform destroy..."
  terraform init
  terraform destroy -auto-approve
  exit
}

Write-Host "Initializing and applying Terraform..."
terraform init
terraform apply -auto-approve
