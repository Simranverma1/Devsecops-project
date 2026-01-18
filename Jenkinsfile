pipeline {
agent any
environment {
TF_DIR = "terraform"
}
stages {
stage('Checkout') {
steps {
checkout scm
sh 'ls -la'
}
}


stage('Trivy IaC Scan (initial)') {
steps {
sh 'chmod +x ci-scripts/run_trivy.sh'
sh './ci-scripts/run_trivy.sh terraform trivy_report.json || true'
sh 'ls -la'
}
post {
  always {
    script {
      if (fileExists('trivy_report.json')) {
        archiveArtifacts artifacts: 'trivy_report.json', fingerprint: true
      } else {
        echo 'Trivy report missing, skipping archive'
      }
    }
  }
}


stage('AI Remediation (Local LLM)') {
steps {
sh 'chmod +x ci-scripts/ai_remediate.sh'
sh './ci-scripts/ai_remediate.sh trivy_report.json terraform ai_response.json || true'
archiveArtifacts artifacts: 'ai_response.json'
}
}


stage('Apply Manual Fixes / Re-scan') {
steps {
echo "If AI produced fixes, review ai_response.json and apply them to terraform/ manually or copy terraform_fixed/"
sh './ci-scripts/run_trivy.sh terraform trivy_report_after.json || true'
archiveArtifacts artifacts: 'trivy_report_after.json'
}
}


stage('Terraform Plan') {
steps {
dir('terraform') {
sh 'terraform init -input=false'
sh 'terraform validate || true'
sh 'terraform plan -out=tfplan || true'
sh 'terraform show -json tfplan > tfplan.json || true'
}
}
post {
always { archiveArtifacts artifacts: 'terraform/*.tf, terraform/tfplan, terraform/tfplan.json', fingerprint: true }
}
}
}
}
