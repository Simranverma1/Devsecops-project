#!/bin/bash
set -euo pipefail


REPORT=${1:-trivy_report.json}
TF_DIR=${2:-terraform}
OUTPUT=${3:-ai_response.json}


if [ ! -f "$REPORT" ]; then
echo "Trivy report not found: $REPORT"
exit 1
fi


PROMPT=$(cat <<EOF
You are a DevSecOps security engineer. Given the following Trivy IaC JSON report, explain each finding and provide minimal Terraform file snippets to fix them. Output plain text (human readable) with separators.


$(cat "$REPORT")
EOF
)


# Use Ollama local model (must be installed and model pulled)
ollama run llama3.2:1b "$PROMPT" > "$OUTPUT"


echo "AI remediation suggestions saved to $OUTPUT"
