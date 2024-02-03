#!/bin/bash

# Default Kubernetes version
DEFAULT_K8S_VERSION="stable"

# Function to print a message
message() {
    echo "Message: $1"
}

# Function to print an error
error() {
    echo "Error: $1" >&2
}

# Function to run a command
run() {
    local cmd=$1
    shift
    echo "Running: $cmd $*"
    "$cmd" "$@" 2> /dev/null
    return $?
}

# Check for subcommands
if [ "$#" -eq 0 ]; then
    echo "No subcommand provided"
    exit 1
fi

SUBCMD=$1
shift

# Handling different subcommands
case $SUBCMD in
    stop)
        message "Stopping minikube"
        run minikube stop
        ;;
    delete)
        SKIP_CONFIRMATION=false
        while getopts "y" opt; do
            case $opt in
                y)
                    SKIP_CONFIRMATION=true
                    ;;
                \?)
                    echo "Invalid option: -$OPTARG" >&2
                    ;;
            esac
        done
        message "Deleting the minikube instance."
        if [ "$SKIP_CONFIRMATION" = false ]; then
            read -p "Do you want to continue? [Y/N] " response
            case $response in
                [Yy]* ) ;;
                * ) exit ;;
            esac
        fi
        run minikube delete
        ;;
    start)
        VERSION=$DEFAULT_K8S_VERSION
        DRIVER=""
        CPU="3"
        RAM="9g"
        DISK="40g"

        while getopts "v:d:c:r:k:" opt; do
            case $opt in
                v) VERSION=$OPTARG ;;
                d) DRIVER=$OPTARG ;;
                c) CPU=$OPTARG ;;
                r) RAM=$OPTARG ;;
                k) DISK=$OPTARG ;;
                \?) echo "Invalid option: -$OPTARG" >&2 ;;
            esac
        done

        DRV_OPTS=""
        case $DRIVER in
            docker) DRV_OPTS="--driver=docker" ;;
            hyperkit) DRV_OPTS="--driver=hyperkit" ;;
            vb) DRV_OPTS="--driver=virtualbox --bootstrapper=kubeadm" ;;
            vmware) DRV_OPTS="--driver=vmware" ;;
            kvm2) DRV_OPTS="--driver=kvm2" ;;
        esac

        if [ "$(uname)" == "Darwin" ]; then
            if [ "$DRIVER" == "kvm2" ]; then
                error "The kvm2 driver is not available on macOS"
                exit 1
            fi
            if [ "$(uname -m)" == "x86_64" ]; then
                if [ "$DRIVER" == "docker" ]; then
                    error "The docker driver is not supported on Intel-based Macs"
                    exit 1
                fi
            elif [ "$(uname -m)" == "arm64" ]; then
                if [ "$DRIVER" == "hyperkit" ]; then
                    error "The hyperkit driver is not available on ARM-based Macs"
                    exit 1
                fi
            fi
        fi

        MINIKUBE_ARGS="start --cpus=$CPU --memory=$RAM --disk-size=$DISK --cni=true --kubernetes-version=$VERSION --addons=ingress,volumesnapshots,metrics-server $DRV_OPTS"
        message "Running: minikube $MINIKUBE_ARGS"
        run minikube $MINIKUBE_ARGS
        ;;
    *)
        echo "Invalid command: $SUBCMD"
        exit 1
        ;;
esac
