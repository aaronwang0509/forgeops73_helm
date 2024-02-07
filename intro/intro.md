# ForgeOps Helm Project Introduction

This project provides a Helm chart for deploying the ForgeOps platform on Kubernetes clusters. It is designed to streamline the deployment of ForgeRock's Identity and Access Management suite, making it easier to manage and scale. The project is structured to support various Kubernetes environments, including Minikube and AWS, ensuring flexibility across different deployment scenarios.

## Project Structure

The project is organized into several key directories, each containing essential components for the deployment and management of the ForgeOps platform:

- `forgeops.sh`: A utility script that simplifies the process of managing deployments across different environments.
- `cluster`: Contains scripts and configurations for creating Kubernetes clusters on different platforms.
- `controllers`: Houses configurations and scripts for setting up basic dependencies required before deploying ForgeOps Helm charts.
- `helm`: Includes the Helm chart for the ForgeOps project, featuring several subcharts for each component of the ForgeOps suite.
- `intro`: Provides an introduction to the project and detailed documentation for each component.

## Detailed Introductions

For more in-depth information about each component and how to utilize them in your ForgeOps deployment, please refer to the following documentation:

- [Using forgeops.sh](./forgeops_sh.md): Discover how to manage your ForgeOps deployments efficiently with the `forgeops.sh` script.
- [Cluster Setup](./cluster.md): Learn how to prepare Kubernetes clusters on various platforms using the tools and scripts provided.
- [Controllers Configuration](./controllers.md): Understand how to set up the necessary dependencies for the ForgeOps deployment.
- [Helm Chart Customization](./helm.md): Dive into the details of the ForgeOps Helm chart and how to customize it for your deployment needs.

