# SecOps SOC on Kubernetes

This repository contains a full SOC/SIEM stack deployed on Kubernetes (kind).

## Stack
- Elasticsearch
- Kibana
- Logstash
- Falco
- ElastAlert2
- Kyverno
- Cortex
- TheHive
- Oproxy (SOC Landing Page)

## Namespace
- secops

## Deployment
Use Helm to deploy each component:
```
kubectl create ns secops
helm install elasticsearch charts/elasticsearch -n secops
helm install kibana charts/kibana -n secops
# ...continue as per order
```
