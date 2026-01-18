#!/bin/bash
set -euo pipefail

TARGET_DIR=${1:-terraform}
OUT=${2:-trivy_report.json}

echo "Running Trivy config scan on $TARGET_DIR -> $OUT"

# Use Trivy installed in the Jenkins container / agent
trivy config --format json -o "$OUT" "$TARGET_DIR" || true

if [ -f "$OUT" ]; then
  echo "Trivy report generated: $OUT"
else
  echo "WARNING: Trivy report not generated"
fi
