# Cluster Folder Overview

The `cluster` folder is a key part of the Helm chart version of the ForgeOps project, designed to facilitate the creation of Kubernetes clusters on various platforms. This directory contains two main subfolders: `minikube` for creating cluster on macOS/Linux systems, and `forgeops-extras` for cloud based Kubernetes cluster setup, like GKE, EKS, and AKS.

## Minikube Subfolder

The `minikube` subfolder contains a single shell script, `minikube.sh`, which automates the process of managing a Minikube cluster. Minikube is a tool that allows you to run Kubernetes locally. The `minikube.sh` script supports operations such as starting, stopping, and deleting your Minikube cluster.

### Basic Commands

- Start a Minikube cluster: `minikube start`
- Delete a Minikube cluster: `minikube delete`

**Note**: The `forgeops.sh` script initiates the Minikube cluster with default parameters. These include:

Kubernetes Version=stable, Driver=docker, CPU=3, RAM=9g, Disk Size=40g

### Script Customization

The script accepts various parameters to customize the Minikube cluster. For example, you can specify the Kubernetes version, the virtualization driver, and resources like CPU, RAM, and disk size.

#### Customized Parameters:

- **Version (`-v`)**: Specifies the Kubernetes version.
- **Driver (`-d`)**: Selects the virtualization driver. Options include `docker`, `hyperkit` (macOS), `virtualbox`, `vmware`, and `kvm2` (Linux).
- **CPU (`-c`)**: Sets the number of CPUs allocated to the cluster.
- **RAM (`-r`)**: Defines the amount of RAM allocated to the cluster.
- **Disk (`-k`)**: Determines the disk size allocated to the cluster.

#### Example Usage:

```bash
./minikube.sh start -v 1.20.2 -d docker -c 4 -r 8g -k 50g
```
## Forgeops-Extras Subfolder

The `forgeops-extras` folder contains Terraform scripts and other artifacts for use with the ForgeOps project, focusing on cloud infrastructure provisioning for Kubernetes clusters.

### Terraform Configuration

- **Location**: `terraform/terraform.tfvars` contains variable settings for creating/configuring clusters on GKE, EKS, and AKS.
- **Customization**: To customize cluster configurations, copy `terraform.tfvars` to `override.auto.tfvars` and adjust your cluster settings as desired.

For detailed Terraform variable definitions, refer to the [Terraform documentation](https://www.terraform.io/docs/configuration/variables.html#variable-definitions-tfvars-files).

### Cluster Creation and Teardown

- **Creation**: Execute `./tf-apply` in the `terraform` directory to apply your configuration and create the cluster.
- **Teardown**: Use `./tf-destroy`, optionally with `-target=module.<cluster_config>`, to tear down specific clusters.

### AWS EKS Cluster Setup

By default, the `forgeops.sh` script activates `tf_cluster_eks_small` for AWS EKS, which is configured as follows:

- **Type**: `eks`
- **Region**: `us-east-2`
- **Node Pool**: `m5.2xlarge`, 3-6 nodes

#### Customizing EKS Clusters

To activate a different size, such as `eks_medium` or `eks_large`, modify `override.auto.tfvars`:

- Set `tf_cluster_eks_medium` or `tf_cluster_eks_large` `enabled` to `true`, while disabling `eks_small`.
- Adjust configurations like `cluster_name`, `region`, `zones`, and `node_pools` as necessary.

### Future Support

Future updates will extend support to AKS and GKE clusters, enabling diverse cloud environments for ForgeOps deployments.



