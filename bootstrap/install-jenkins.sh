#!/usr/bin/env bash
set -e

echo "🚀 Bootstrapping Jenkins"

kubectl apply -f jenkins/namespace.yaml

helm repo add jenkins https://charts.jenkins.io
helm repo update

helm upgrade --install jenkins jenkins/jenkins   -n jenkins   -f jenkins/values.yaml

kubectl rollout status statefulset/jenkins -n jenkins
