#!/usr/bin/env bash
set -e

echo "🚀 Bootstrapping Jenkins"

# Create namespace
kubectl apply -f jenkins/namespace.yaml

# Add Helm repo and update
helm repo add jenkins https://charts.jenkins.io
helm repo update

# Install / upgrade Jenkins using KIND-specific values
helm upgrade --install jenkins jenkins/jenkins \
  -n jenkins \
  -f ../environments/kind/jenkins-values.yaml

# Wait for rollout
kubectl rollout status statefulset/jenkins -n jenkins

