#!/usr/bin/env bash
set -e

CHARTS_DIR="charts"
NAMESPACE="secops"

TOOLS=(
  elasticsearch
  kibana
  logstash
  elastalert2
  falcosidekick
  kyverno
  thehive
  cortex
  oproxy
  nginx
  falco
)

echo "🧹 Cleaning old charts..."
rm -rf ${CHARTS_DIR}
mkdir -p ${CHARTS_DIR}

echo "🚀 Starting SecOps Helm charts setup..."

# -----------------------------
# Functions
# -----------------------------

create_chart_yaml() {
cat <<EOF
apiVersion: v2
name: $1
description: Helm chart for $1 (SecOps stack)
type: application
version: 0.1.0
appVersion: "1.0.0"
EOF
}

create_values_yaml() {
cat <<EOF
replicaCount: 1

image:
  repository: $1/$1
  tag: latest
  pullPolicy: IfNotPresent

service:
  type: ClusterIP
  port: 80

resources: {}
EOF
}

create_helpers_tpl() {
cat <<EOF
{{- define "$1.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "$1.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}
EOF
}

create_deployment_yaml() {
cat <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "$1.fullname" . }}
  labels:
    app: {{ include "$1.name" . }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: {{ include "$1.name" . }}
  template:
    metadata:
      labels:
        app: {{ include "$1.name" . }}
    spec:
      containers:
        - name: $1
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          ports:
            - containerPort: {{ .Values.service.port }}
          resources:
{{ toYaml .Values.resources | indent 12 }}
EOF
}

# -----------------------------
# Chart creation
# -----------------------------

for tool in "${TOOLS[@]}"; do
  echo "📦 Creating chart: $tool"

  mkdir -p ${CHARTS_DIR}/${tool}/templates

  create_chart_yaml "$tool" > ${CHARTS_DIR}/${tool}/Chart.yaml
  create_helpers_tpl "$tool" > ${CHARTS_DIR}/${tool}/templates/_helpers.tpl

  # Falco is DaemonSet-based (NO Deployment)
  if [[ "$tool" != "falco" ]]; then
    create_values_yaml "$tool" > ${CHARTS_DIR}/${tool}/values.yaml
    create_deployment_yaml "$tool" > ${CHARTS_DIR}/${tool}/templates/deployment.yaml
  else
    cat <<EOF > ${CHARTS_DIR}/${tool}/values.yaml
falco:
  enabled: true
EOF
  fi
done

# -----------------------------
# Helm Lint
# -----------------------------

echo "🔍 Running helm lint on all charts..."

for chart in ${CHARTS_DIR}/*; do
  echo "➡️  Linting $(basename $chart)..."
  helm lint "$chart"
done

echo "✅ All SecOps Helm charts created & linted successfully!"

