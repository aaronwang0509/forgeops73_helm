# forgeops.sh Script Overview

The `forgeops.sh` script is a vital component of the project. It simplifies the process of managing Kubernetes clusters and deploying ForgeOps on different platforms such as Minikube and AWS. This script streamlines various tasks including installation, deletion, and retrieving information about the deployment.

## Script Usage

To use the script, run it with a command and necessary arguments. The general syntax is:

```
./forgeops.sh [command] [arguments]
```

## Available Commands

### 1. Help

Show the help message with usage information and available commands.

- **Syntax**:
```
./forgeops.sh -h

Usage: ./forgeops.sh [command] [arguments]

Commands:
    install [minikube|aws]   Install on specified platform
    delete [minikube|aws]    Delete from specified platform
    info                     Display information
    ip                       Get IP address based on Kubernetes context
    -h, --help               Show this help message

Examples:
    ./forgeops.sh install minikube      Install on Minikube
    ./forgeops.sh delete aws            Delete from AWS
```

### 2. Install

Install the ForgeOps project on the specified platform. Supported platforms are Minikube and AWS.

- **Syntax**:
```
./forgeops.sh install [minikube|aws]
```
- **Examples**:
    - Install on Minikube: `./forgeops.sh install minikube`
    - Install on AWS: `./forgeops.sh install aws`

### 3. Delete

Delete the whole cluster from the specified platform.

- **Syntax**:
```
./forgeops.sh delete [minikube|aws]
```
- **Examples**:
    - Delete from Minikube: `./forgeops.sh delete minikube`
    - Delete from AWS: `./forgeops.sh delete aws`

### 4. IP

Retrieves the IP address based on the Kubernetes context.

- **Syntax**:
```
./forgeops.sh ip
```

### 5. Info

Displays login informations about the current deployment.

- **Syntax**:
```
./forgeops.sh info
```
