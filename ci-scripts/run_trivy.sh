#!/bin/bash
set -e

TARGET_DIR=${1:-terraform}
OUT=${2:-trivy_report.json}

echo "Running Trivy IaC scan..."

trivy config "$TARGET_DIR" --format json > "$OUT" || true

echo "Trivy report generated: $OUT"
