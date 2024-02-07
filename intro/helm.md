# Helm Foler Overview

The `helm` folder contains the Helm chart for deploying the ForgeOps components on Kubernetes clusters. This chart includes subcharts for each ForgeOps component, ensuring a flexible and scalable deployment strategy.

## Deployment with `forgeops.sh`

To deploy the ForgeOps Helm chart, the `forgeops.sh` script uses the following command, specifying an environment-specific values file (`minikube.yaml` or `aws.yaml`):

```
For Minikube deployments:
helm upgrade helm ./helm_cm --install -f helm_cm/minikube.yaml

For AWS deployments:
helm upgrade helm ./helm_cm --install -f helm_cm/aws.yaml
```

These commands deploy ForgeOps on the chosen platform, utilizing the configurations defined in the respective YAML files.

### Example Configuration: `minikube.yaml`

The `minikube.yaml` values file customizes the ForgeOps deployment for Minikube, detailing configurations such as FQDN, platform-specific settings, and resources for each component. Key sections include:

- **`base`**: Global configurations like FQDN, ingress TLS certificate, and platform-specific settings such as the ForgeOps platform size and certificate issuer.
- **`secrets`**: Defines secret management, including certificate subject details.
- **`ds`**: Configures Directory Services with labels, passwords, image details, resource limits, and storage options.
- **`am`**: Access Management service settings, including service type, replicas, labels, and resource allocations, along with environment variables and image configurations.
- **`idm`**: Identity Management service configurations for service type, ports, labels, replicas, and IDM environment, including image repository and resource limits.

### Customizing Helm Chart Values

You can modify the values in `minikube.yaml` or `aws.yaml` to customize the ForgeOps deployment. Adjustments can be made to service replicas, resource limits, FQDN, and more, by editing the values in the YAML file before deployment with `forgeops.sh`.

This approach allows deployments to be tailored to specific requirements, optimizing resource allocation and ensuring compatibility with the deployment environment.

### Example Customization
To add an environment variable to the Access Management (AM) component using the `platform-config` ConfigMap in the ForgeOps Helm chart, follow these steps. This example will demonstrate adding a `PLATFORM_TEST_*` environment variable.

1. **Reference `platform-config` in AM Configuration:**

The AM deployment already references the `platform-config` ConfigMap as a source for environment variables in `am_dpl.yaml`. This allows AM pods to inherit any configurations defined within the `platform-config` ConfigMap.

```
envFrom:

configMapRef:
name: platform-config
```

This setup ensures that all key-value pairs in the `platform-config` ConfigMap are injected as environment variables into the AM pods.

2. **Add Environment Variable in `platform_config_cm.yaml`:**

To introduce a new environment variable, edit the `platform_config_cm.yaml` template within the `base` chart's `templates` directory. Add the new environment variable to the `data` section of the ConfigMap. For example, to add `PLATFORM_TEST_VAR`:

```
data:
...
PLATFORM_TEST_VAR: {{ .Values.platformConfig.platformTestVar | quote }}
```

This line assigns the value of `platformConfig.platformTestVar` from the chart's values file (`minikube.yaml` or `aws.yaml`) to the `PLATFORM_TEST_VAR` environment variable within the ConfigMap.

3. **Define Actual Values in `minikube.yaml` or `aws.yaml`:**

Finally, specify the actual value for `PLATFORM_TEST_VAR` in your environment-specific values file (`minikube.yaml` or `aws.yaml`). For example, in `minikube.yaml`, add:

```
platformConfig:
...
platformTestVar: "YourTestValue"
```
Replace `"YourTestValue"` with the actual value you want to assign to `PLATFORM_TEST_VAR`.

By following these steps, you integrate a new environment variable (`PLATFORM_TEST_VAR`) into the AM component's environment. This process showcases the flexibility of Helm charts in managing configurations across different environments and components within a Kubernetes deployment.