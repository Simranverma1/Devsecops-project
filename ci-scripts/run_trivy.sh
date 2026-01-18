#!/bin/bash
set -euo pipefail


TARGET_DIR=${1:-terraform}
OUT=${2:-trivy_report.json}


# Run Trivy IaC scan (requires trivy installed in PATH)
trivy iac --format json --output "$OUT" "$TARGET_DIR" || true


echo "Trivy IaC scan done -> $OUT"
