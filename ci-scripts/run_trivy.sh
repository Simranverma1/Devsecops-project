#!/bin/bash
set -euo pipefail

TARGET_DIR=${1:-terraform}
OUT=${2:-trivy_report.json}

# run Trivy using Docker (requires Docker socket mounted in Jenkins)
docker run --rm \
  -v "$(pwd)":/data \
  aquasec/trivy:latest \
  iac --format json --output /data/"$OUT" /data/"$TARGET_DIR" || true

echo "Trivy IaC scan done -> $OUT"
