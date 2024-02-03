# ForgeOps Helm Deployment Guide

This guide provides step-by-step instructions for ForgeOps Helm project based on ForgeOps 7.3 version.

## Prerequisites

Before proceeding, ensure you have the following software installed:

- Python3 (python3) (Version 3.11.6)
- Docker client (docker) (Version 24.0.6)
- Kubernetes client (kubectl) (Version 1.28.4)
- Kubernetes context switcher (kubectx) (Version 0.9.5)
- Kustomize (kustomize) (Version 5.2.1)
- Helm (helm) (Version 3.13.2)
- Terraform (terraform) (Version 1.7.1)
- JQ (jq) (Version 1.17)
- Minikube (minikube) (Version 1.32.0)
- Hyperkit (hyperkit) (Version 0.20210107) - for Intel x86-based macOS systems only
- Amazon AWS Command Line Interface (aws) (Version 2.11.13)
- AWS IAM Authenticator for Kubernetes (aws-iam-authenticator) (Version 0.6.2)

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/autumnfallenwang/forgeops73_helm.git
```

### 2. Deployment

#### 2.1 Setup AWS Credentials (AWS only)

Get or create a new access key from your AWS account, then run:

```bash
aws configure
```

#### 2.2 Install on Specified Platform

For Minikube:

```bash
minikube delete # if you already have a minikube cluster running
./forgeops.sh install minikube
```

For AWS:

```bash
./forgeops.sh install aws
```

### 3. Accessing the Deployment

#### 3.1 Get IP Address Based on Kubernetes Context

```bash
./forgeops.sh ip
```

#### 3.2 Setup Hosts IP Address

Edit the `/etc/hosts` file:

```plaintext
#
cluster_ip    cdk.example.com 
#
```

#### 3.3 Get Login Information

```bash
./forgeops.sh info
```

### 4. Cleaning Up

Delete the deployment from the specified platform:

For Minikube:

```bash
./forgeops.sh delete minikube
```

For AWS:

```bash
./forgeops.sh delete aws
```

## TODO

### 1. Add customized build docker images

### 2. Add automatic CI/CD pipeline