# Controllers Folder Overview

The `controllers` folder contains essential configurations and scripts for setting up basic dependencies required before deploying ForgeOps Helm charts. This includes configurations for `cert-manager`, `secret-agent`, and `ds-operator` along with utility scripts like `install_all.sh` and `print_info.sh`.

## `install_all.sh` Script

The `install_all.sh` script automates the deployment of necessary Kubernetes resources and operators such as cert-manager, secret-agent, and ds-operator. It checks for the existence of each component and applies the required configurations if they are not found. Importantly, after installing each component, the script ensures to wait until the resource is fully ready before proceeding to the next, guaranteeing that the ForgeOps dependencies are correctly installed, configured, and operational before the main Helm chart deployment.

### Basic Functions:

- **Cert-manager**: Installs the cert-manager CRDs and the cert-manager itself to manage certificates within the Kubernetes cluster.
- **Secret-agent**: Applies the secret-agent configuration, setting up a mechanism to handle secret management within the cluster.
- **DS-operator**: Deploys the ds-operator to manage ForgeRock Directory Services within the Kubernetes environment.

The `forgeops.sh` script utilizes `install_all.sh` after the cluster has been built to prepare the environment for ForgeOps deployment.

## `print_info.sh` Script

The `print_info.sh` script is designed to print deployment information, such as Fully Qualified Domain Names (FQDNs) of the deployed services, and relevant passwords and URLs for accessing the ForgeOps services. This script is invaluable for obtaining quick access details and ensuring the deployment's operational status.

### Basic Functions:

- **Get FQDN**: Retrieves the FQDN of the deployment based on the ingress configuration.
- **Print Secrets**: Displays important passwords used within the ForgeOps deployment.
- **Print URLs**: Lists accessible URLs for the ForgeOps platform, including the admin console, end-user pages, and more.

The `forgeops.sh` script uses `print_info.sh` with the `info` command to provide deployment details after the ForgeOps project has been deployed, facilitating easy access to the deployed services.

