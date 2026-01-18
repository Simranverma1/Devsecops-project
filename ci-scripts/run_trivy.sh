#!/bin/bash
set -euo pipefail

TARGET_DIR=${1:-terraform}
OUT=${2:-trivy_report.json}

echo "Running Trivy IaC scan..."

trivy config "$TARGET_DIR" -f json -o "$OUT" || true

if [ -f "$OUT" ]; then
  echo "Trivy report generated: $OUT"
else
  echo "Trivy report not generated"
fi

