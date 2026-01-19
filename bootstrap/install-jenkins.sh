#!/usr/bin/env bash
set -e

echo "🚀 Bootstrapping Jenkins"

# Ensure we are in repo root
REPO_ROOT=$(pwd)
echo "Repo root: $REPO_ROOT"

# Apply namespace
kubectl apply -f "$REPO_ROOT/jenkins/namespace.yaml"

# Add Helm repo
helm repo add jenkins https://charts.jenkins.io
helm repo update

# Install/upgrade Jenkins using KIND values.yaml
helm upgrade --install jenkins jenkins/jenkins \
  -n jenkins \
  -f "$REPO_ROOT/environments/kind/jenkins-values.yaml"

# Wait for rollout
kubectl rollout status statefulset/jenkins -n jenkins

