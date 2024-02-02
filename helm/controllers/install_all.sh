#!/bin/bash

# Apply cert-manager.crds.yaml
echo "Applying cert-manager.crds.yaml..."
kubectl apply -f cert-manager.crds.yaml
echo "Applied cert-manager.crds.yaml. Sleeping for 10 seconds..."
sleep 10

# Apply cert-manager.yaml
echo "Applying cert-manager.yaml..."
kubectl apply -f cert-manager.yaml
echo "Applied cert-manager.yaml. Sleeping for 10 seconds..."
sleep 10

# Apply secret-agent.yaml
echo "Applying secret-agent.yaml..."
kubectl apply -f secret-agent.yaml
echo "Applied secret-agent.yaml. Sleeping for 10 seconds..."
sleep 10

# Apply ds-operator.yaml
echo "Applying ds-operator.yaml..."
kubectl apply -f ds-operator.yaml
echo "Applied ds-operator.yaml. Sleeping for 20 seconds..."
sleep 20

echo "All YAML files have been applied successfully."
