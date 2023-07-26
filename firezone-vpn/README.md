# Firezone VPN helm chart

This chart deploys Firezone VPN to Your K8S Cluster.

## Requirements

* [Kubernetes](https://kubernetes.io/) >= 1.19
* [Helm](https://helm.sh/) >= 3

## How to install

Clone repository to Your Local PC. (Only Users in that Organization can do it).

```bash
git clone git@github.com:zenelys/helm-charts.git

cd firezone-vpn
```

Run the following command

```bash
helm install firezone -n firezone . --create namespace
```

Or You can create Your own `values.yaml` and install Chart from it.

```bash
helm install firezone . --values values.yaml
```

## Parameters

### Firezone VPN

| Name                                             | Description                                                                           | Value           |
| ------------------------------------------------ | ------------------------------------------------------------------------------------- | --------------- |
| `firezone.deployment.metadata.name`              | Firezone deployment name (Optional).                                                  | `""`            |
| `firezone.deployment.metadata.labels`            | Annotations for firezone deployment.                                                  | `{}`            |
| `firezone.deployment.metadata.annotations`       | Extra labels for deployment.                                                          | `{}`            |
| `firezone.namespaceOverride`                     | Namespace for chart components                                                        | `""`            |
| `firezone.replicaCount`                          | The number of replicas (instances) of the application that should be running          | `1`             |
| `firezone.strategy.type`                         | Deployment update strategy                                                            | `RollingUpdate` |
| `firezone.strategy.rollingUpdate.maxUnavailable` | max unavailable replicas during rolling update process                                | `25%`           |
| `firezone.strategy.rollingUpdate.maxSurge`       | maximum number of Pods that can be created over the desired number of Pods            | `25%`           |
| `firezone.image.registry`                        | Specifies The Container image registry.                                               | `firezone`      |
| `firezone.image.repository`                      | Specifies the Container image to use for the application and its associated settings. | `""`            |
| `firezone.image.pullPolicy`                      | Specifies the Image PullPolicy.                                                       | `IfNotPresent`  |
| `firezone.image.tag`                             | Overrides the image tag whose default is the chart appVersion.                        | `""`            |
| `firezone.resources`                             | Resources configuration for Firezone.                                                 | `{}`            |

### Firezone Node Selectors, Tolerations, Affinities

| Name                    | Description                                                            | Value |
| ----------------------- | ---------------------------------------------------------------------- | ----- |
| `firezone.nodeSelector` | Specifies settings for node selection when scheduling pods.            | `{}`  |
| `firezone.tolerations`  | Specifies Kubernetes tolerations for the pods created by the chart.    | `[]`  |
| `firezone.affinity`     | Specifies Kubernetes affinity rules for the pods created by the chart. | `{}`  |

### Firezone web service configuration

| Name                                       | Description                              | Value       |
| ------------------------------------------ | ---------------------------------------- | ----------- |
| `firezone.serviceweb.metadata.name`        | Firezone web service name (Optional).    | `""`        |
| `firezone.serviceweb.metadata.labels`      | Extra labels for firezone web service.   | `{}`        |
| `firezone.serviceweb.metadata.annotations` | Annotations for firezone web service.    | `{}`        |
| `firezone.serviceweb.type`                 | Firezone web service type.               | `ClusterIP` |
| `firezone.serviceweb.port`                 | Port to expose for firezone web service. | `13000`     |

### Firezone vpn traffic service configuration

| Name                                             | Description                                                        | Value       |
| ------------------------------------------------ | ------------------------------------------------------------------ | ----------- |
| `firezone.servicewireguard.metadata.name`        | Firezone vpn traffic service name (Optional).                      | `""`        |
| `firezone.servicewireguard.metadata.labels`      | Extra labels for firezone vpn traffic service.                     | `{}`        |
| `firezone.servicewireguard.metadata.annotations` | Annotations for firezone vpn traffic service.                      | `{}`        |
| `firezone.servicewireguard.type`                 | Firezone vpn traffic service type.                                 | `LoadBalancer` |
| `firezone.servicewireguard.loadBalancerClass`    | LoadbalancerClass for vpn traffic service.                         | `""`        |
| `firezone.servicewireguard.port`                 | Port to expose for firezone vpn traffic service.                   | `51820`     |

### Firezone Ingress Specifies settings for the Kubernetes Ingress resource

| Name                              | Description                                                                                      | Value              |
| --------------------------------- | ------------------------------------------------------------------------------------------------ | ------------------ |
| `firezone.ingress.enabled`        | To enable or disable ingress.                                                                    | `false`            |
| `firezone.ingress.className`      | Ingress Class name.                                                                              | `""`               |
| `firezone.ingress.name`           | Ingress name.                                                                                    | `""`               |
| `firezone.ingress.labels`         | Ingress resource labels.                                                                         | `{}`               |
| `firezone.ingress.annotations`    | Ingress resource annotations.                                                                    | `{}`               |
| `firezone.ingress.host`           | Application hostname.                                                                            | `example.host`     |
| `firezone.ingress.tls.hosts`      | To Application hostname in TLS settings.                                                         | `["example.host"]` |
| `firezone.ingress.tls.enabled`    | To enable or disable TLS                                                                         | `false`            |
| `firezone.ingress.tls.secretName` | TLS secret name of the ingress. If enabled and no secretName specified, new one will be created. | `""`               |

### Secret for Firezone

| Name                          | Description                           | Value |
| ----------------------------- | ------------------------------------- | ----- |
| `firezone.secret.name`        | Firezone secret name.                 | `""`  |
| `firezone.secret.labels`      | Firezone secret labels.               | `{}`  |
| `firezone.secret.annotations` | Firezone secret annotations.          | `{}`  |
| `firezone.secret.data`        | If You want to change default values. | `{}`  |

>You can generate vales with this command. `docker run --rm firezone/firezone bin/gen-env > .env`

```yaml
  secret:
    name: "firezone"
    labels: {}
    annotations: {}  
    data:
      EXTERNAL_URL: <YOUR_EXTRA_URL>
      VERSION: value from .env file
      DEFAULT_ADMIN_EMAIL: <YOUR_ADMIN_EMAIL>
      DEFAULT_ADMIN_PASSWORD: value from .env file
      GUARDIAN_SECRET_KEY: value from .env file
      SECRET_KEY_BASE: value from .env file
      LIVE_VIEW_SIGNING_SALT: value from .env file
      COOKIE_SIGNING_SALT: value from .env file
      COOKIE_ENCRYPTION_SALT: value from .env file
      DATABASE_ENCRYPTION_KEY: value from .env file
      DATABASE_PASSWORD: value from .env file
      WIREGUARD_IPV4_NETWORK: value from .env file
      WIREGUARD_IPV4_ADDRESS: value from .env file
      WIREGUARD_IPV6_NETWORK: value from .env file
      WIREGUARD_IPV6_ADDRESS: value from .env file
```

> If Your generated new Values for Secret, You need to change <span style="color:red">POSTGRES_PASSWORD</span> in Postgres Section. <a href="#postgres-section">View Postgres Section</a>

### Firezone Persistence Volume

| Name                                    | Description                                                                        | Value               |
| --------------------------------------- | ---------------------------------------------------------------------------------- | ------------------- |
| `firezone.persistence.type`             | persistence type.                                                                  | `pvc`               |
| `firezone.persistence.enabled`          | For enable/disable persisyence(If desabled You can loss data after pod restarting) | `false`             |
| `firezone.persistence.storageClassName` | Storage class name.                                                                | `""`                |
| `firezone.persistence.accessModes`      | Access modes for storage.                                                          | `["ReadWriteOnce"]` |
| `firezone.persistence.size`             | Persistence volume size.                                                           | `10Gi`              |

### Firezone postgres db statefulset

| Name                                     | Description                                                                           | Value          |
| ---------------------------------------- | ------------------------------------------------------------------------------------- | -------------- |
| `postgres.enabled`                       | Enable/disable PostgreSQL.(Optional).                                                 | `true`         |
| `postgres.stateful.metadata.name`        | Postgres statedulset name (Optional).                                                 | `""`           |
| `postgres.stateful.metadata.labels`      | Annotations for postgres statefulset.                                                 | `{}`           |
| `postgres.stateful.metadata.annotations` | Extra labels for statefulset.                                                         | `{}`           |
| `postgres.replicaCount`                  | The number of replicas (instances) of the application that should be running          | `1`            |
| `postgres.image.registry`                | Specifies The Container image registry.                                               | `library`      |
| `postgres.image.repository`              | Specifies the Container image to use for the application and its associated settings. | `""`           |
| `postgres.image.pullPolicy`              | Specifies the Image PullPolicy.                                                       | `IfNotPresent` |
| `postgres.image.tag`                     | Overrides the image tag whose default is the chart appVersion.                        | `""`           |
| `postgres.resources`                     | Resources configuration for Postgres.                                                 | `{}`           |

### Postgres Node Selectors, Tolerations, Affinities

| Name                    | Description                                                            | Value |
| ----------------------- | ---------------------------------------------------------------------- | ----- |
| `postgres.nodeSelector` | Specifies settings for node selection when scheduling pods.            | `{}`  |
| `postgres.tolerations`  | Specifies Kubernetes tolerations for the pods created by the chart.    | `[]`  |
| `postgres.affinity`     | Specifies Kubernetes affinity rules for the pods created by the chart. | `{}`  |

### Postgres db service configuration

| Name                                    | Description                             | Value       |
| --------------------------------------- | --------------------------------------- | ----------- |
| `postgres.service.metadata.name`        | Postgres db service name (Optional).    | `""`        |
| `postgres.service.metadata.labels`      | Extra labels for postgres db service.   | `{}`        |
| `postgres.service.metadata.annotations` | Annotations for postgres db service.    | `{}`        |
| `postgres.service.type`                 | Postgres dbservice type.                | `ClusterIP` |
| `postgres.service.port`                 | Port to expose for postgres db service. | `5432`      |

### Secret for Postgres <h2 id="postgres-section"></h2>

| Name                          | Description                  | Value |
| ----------------------------- | ---------------------------- | ----- |
| `postgres.secret.name`        | Postgres secret name.        | `""`  |
| `postgres.secret.labels`      | Postgres secret labels.      | `{}`  |
| `postgres.secret.annotations` | Postgres secret annotations. | `{}`  |
| `postgres.secret.data`        | Postgres secret data.        | `{}`  |

>If You have changed values in `Firezone Secret to custom`, then required to add value `DATABASE_PASSWORD` from `.env` in data section.

```yaml
  secret:
    name: ""
    labels: {}
    annotations: {}
    data: 
      POSTGRES_PASSWORD: DATABASE_PASSWORD (value from .env file)
```

### Postgres Persistence Volume

| Name                                    | Description                                                                        | Value               |
| --------------------------------------- | ---------------------------------------------------------------------------------- | ------------------- |
| `postgres.persistence.type`             | Persistence type.                                                                  | `pvc`               |
| `postgres.persistence.enabled`          | For enable/disable persisyence(If desabled You can loss data after pod restarting) | `false`             |
| `postgres.persistence.storageClassName` | Storage class name.                                                                | `""`                |
| `postgres.persistence.accessModes`      | Access modes for storage.                                                          | `["ReadWriteOnce"]` |
| `postgres.persistence.size`             | Persistence volume size.                                                           | `10Gi`              |
