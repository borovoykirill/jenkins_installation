#!/bin/bash

# Assuming you have no clusters created on your current gcloud core/project

REF=$(gcloud container clusters list | grep -v NAME | cut -d' ' -f1)

# Get cluster credentials from GCP

gcloud container clusters get-credentials $REF --zone us-central1-a --project devops2020-kubernetes-271505

# Label nodes

kubectl label node $(kubectl get nodes | grep -v NAME | sort | head -n1 | cut -d' ' -f1) node-role.kubernetes.io/master=
kubectl label node --all node-role.kubernetes.io/worker=

kubectl create ns jenkins

# Deploy jenkins

echo "Deployoing jenkins..."
kubectl apply -f scripts/jenkins1.yml
