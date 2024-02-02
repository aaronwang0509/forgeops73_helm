#!/bin/bash

# Function for displaying help information
help() {
    echo "Usage: $0 [command] [arguments]"
    echo
    echo "Commands:"
    echo "  install [minikube|aws]   Install on specified platform"
    echo "  delete [minikube|aws]    Delete from specified platform"
    echo "  info                     Display information"
    echo "  ip                       Get IP address based on Kubernetes context"
    echo "  -h, --help               Show this help message"
    echo
    echo "Examples:"
    echo "  $0 install minikube      Install on Minikube"
    echo "  $0 delete aws            Delete from AWS"
}

# Function for starting minikube and related processes
install_minikube() {
    cd forgeops/cluster/minikube
    ./cdk-minikube start
    kubectx minikube
    cd ../../../helm/controllers
    ./install_all.sh
    cd ..
    helm upgrade helm ./helm_cm --install -f helm_cm/minikube.yaml
}

# Function for deleting minikube
delete_minikube() {
    cd forgeops/cluster/minikube
    ./cdk-minikube delete
}

# Function for installing on AWS
install_aws() {
    cd forgeops-extras/terraform
    ./tf-apply
    aws eks update-kubeconfig --name tf-idp-small
    cd ../../helm/controllers
    ./install_all.sh
    cd ..
    helm upgrade helm ./helm_cm --install -f helm_cm/aws.yaml
}

# Function for deleting on AWS
delete_aws() {
    cd forgeops-extras/terraform
    ./tf-destroy
}

# Function for displaying information
info() {
    cd helm/controllers
    ./print_info.sh
}

# Function to get IP address based on Kubernetes context
get_ip() {
    current_context=$(kubectl config current-context)
    
    if [[ "$current_context" == "minikube" ]]; then
        minikube ip
    elif [[ "$current_context" == *arn:aws* ]]; then
        kubectl get svc --namespace ingress-nginx | grep 'ingress-nginx-controller ' | awk '{print $4}'
        # Optionally, to resolve the ELB address to an IP, use:
        host $(kubectl get svc --namespace ingress-nginx | grep 'ingress-nginx-controller ' | awk '{print $4}')
    else
        echo "Unknown Kubernetes context: $current_context"
    fi
}

# Main script logic to decide which function to run
case "$1" in
    install)
        case "$2" in
            minikube)
                install_minikube
                ;;
            aws)
                install_aws
                ;;
            *)
                echo "Invalid install command"
                ;;
        esac
        ;;
    delete)
        case "$2" in
            minikube)
                delete_minikube
                ;;
            aws)
                delete_aws
                ;;
            *)
                echo "Invalid delete command"
                ;;
        esac
        ;;
    info)
        info
        ;;
    ip)
        get_ip
        ;;
    -h|--help)
        help
        ;;
    *)
        help
        ;;
esac
