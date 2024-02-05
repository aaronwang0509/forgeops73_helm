#!/bin/bash

echo "Checking for cert-manager..."

# Check for the presence of cert-manager CRDs
if ! kubectl get crd certificaterequests.cert-manager.io > /dev/null 2>&1 ||
   ! kubectl get crd certificates.cert-manager.io > /dev/null 2>&1 ||
   ! kubectl get crd clusterissuers.cert-manager.io > /dev/null 2>&1; then
    echo "Cert-manager not found. Applying configuration..."

    echo "Applying cert-manager.crds.yaml..."
    kubectl apply -f cert-manager.crds.yaml
    sleep 5

    # Wait for CRDs to be established
    echo "Waiting for cert-manager CRDs to be established..."
    kubectl wait --for=condition=Established crd certificaterequests.cert-manager.io --timeout=60s
    kubectl wait --for=condition=Established crd certificates.cert-manager.io --timeout=60s
    kubectl wait --for=condition=Established crd clusterissuers.cert-manager.io --timeout=60s

    echo "Applying cert-manager.yaml..."
    kubectl apply -f cert-manager.yaml
    sleep 5

    # Wait for cert-manager deployments to be available
    echo "Waiting for cert-manager deployments to become available..."
    kubectl -n cert-manager wait --for=condition=available deployment --all --timeout=300s

    # Optionally, wait for all pods to be ready in cert-manager namespace
    echo "Waiting for cert-manager pods to be ready..."
    kubectl -n cert-manager wait --for=condition=ready pod --all --timeout=300s

    echo "Cert-manager setup complete."
else
    echo "Cert-manager already exist."
fi


echo "Checking for secret-agent"

# Check for the presence of the secret-agent CRD
if ! kubectl get crd secretagentconfigurations.secret-agent.secrets.forgerock.io > /dev/null 2>&1; then
    echo "Secret-agent not found. Applying configuration..."

    # Apply the configuration if CRD is not present
    echo "Applying secret-agent.yaml..."
    kubectl apply -f secret-agent.yaml
    sleep 5

    # Wait for CRD to be established
    echo "Waiting for secret-agent CRD to be established..."
    kubectl wait --for=condition=Established crd secretagentconfigurations.secret-agent.secrets.forgerock.io --timeout=30s

    # Wait for secret-agent deployments to be available
    echo "Waiting for secret-agent deployments to become available..."
    kubectl -n secret-agent-system wait --for=condition=available deployment --all --timeout=120s

    # Optionally, wait for all pods to be ready in secret-agent-system namespace
    echo "Waiting for secret-agent pods to be ready..."
    kubectl -n secret-agent-system wait --for=condition=ready pod --all --timeout=120s

    echo "Secret-agent setup complete."
else
    echo "Secret-agent already exist."
fi


echo "Checking for ds-operator..."

# Check for the presence of the ds-operator CRD
if ! kubectl get crd directoryservices.directory.forgerock.io > /dev/null 2>&1; then
    echo "Ds-operator not found. Applying configuration..."
    kubectl delete crd directorybackups.directory.forgerock.io --ignore-not-found=true
    kubectl delete crd directoryrestores.directory.forgerock.io --ignore-not-found=true

    # Apply the configuration if CRD is not present
    echo "Applying ds-operator.yaml..."
    kubectl apply -f ds-operator.yaml
    sleep 5

    # Wait for CRD to be established
    echo "Waiting for ds-operator CRD to be established..."
    kubectl wait --for=condition=Established crd directoryservices.directory.forgerock.io --timeout=30s

    # Wait for ds-operator deployments to be available
    echo "Waiting for ds-operator deployments to become available..."
    kubectl -n fr-system wait --for=condition=available deployment --all --timeout=120s

    echo "Ds-operator setup complete."
else
    echo "Ds-operator already exist."
fi
