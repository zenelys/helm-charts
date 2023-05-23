# Firezone VPN Helm Chart

Dependencies:

- Kubernetes >= 1.19.0

## Parameters

### All values for chart.

### Firezone.

| Name                                             | Description                                                                           | Value           |
| ------------------------------------------------ | ------------------------------------------------------------------------------------- | --------------- |
| `firezone.deployment.metadata.name`              | Firezone deployment name (Optional).                                                  | `""`            |
| `firezone.deployment.metadata.labels`            | Annotations for firezone deployment.                                                  | `{}`            |
| `firezone.deployment.metadata.annotations`       | Extra labels for deployment.                                                          | `{}`            |
| `firezone.namespaceOverride`                     | Namespace for chart components                                                        | `""`            |
| `firezone.replicaCount`                          | The number of replicas (instances) of the application that should be running          | `2`             |
| `firezone.strategy.type`                         | Deployment update strategy                                                            | `RollingUpdate` |
| `firezone.strategy.rollingUpdate.maxUnavailable` | max unavailable replicas during rolling update process                                | `50%`           |
| `firezone.strategy.rollingUpdate.maxSurge`       | maximum number of Pods that can be created over the desired number of Pods            | `25%`           |
| `firezone.image.registry`                        | Specifies The Container image registry.                                               | `firezone`      |
| `firezone.image.repository`                      | Specifies the Container image to use for the application and its associated settings. | `""`            |
| `firezone.image.pullPolicy`                      | Specifies the Image PullPolicy.                                                       | `IfNotPresent`  |
| `firezone.image.tag`                             | Overrides the image tag whose default is the chart appVersion.                        | `""`            |
| `firezone.resources.limits.cpu`                  | Resources limit for cpu.                                                              | `""`            |
| `firezone.resources.limits.memory`               | Resources limits for memory.                                                          | `""`            |
| `firezone.resources.requests.cpu`                | Resources requests for cpu.                                                           | `""`            |
| `firezone.resources.requests.memory`             | Resources requests for memory.                                                        | `""`            |

### Firezone Node Selectors, Tolerations, Affinities. 

| Name                    | Description                                                            | Value |
| ----------------------- | ---------------------------------------------------------------------- | ----- |
| `firezone.nodeSelector` | Specifies settings for node selection when scheduling pods.            | `{}`  |
| `firezone.tolerations`  | Specifies Kubernetes tolerations for the pods created by the chart.    | `[]`  |
| `firezone.affinity`     | Specifies Kubernetes affinity rules for the pods created by the chart. | `{}`  |

### Firezone web service configuration.

| Name                                       | Description                              | Value       |
| ------------------------------------------ | ---------------------------------------- | ----------- |
| `firezone.serviceweb.metadata.name`        | firezone web service name (Optional).    | `""`        |
| `firezone.serviceweb.metadata.labels`      | Extra labels for firezone web service.   | `{}`        |
| `firezone.serviceweb.metadata.annotations` | Annotations for firezone web service.    | `{}`        |
| `firezone.serviceweb.type`                 | firezone web service type.               | `ClusterIP` |
| `firezone.serviceweb.port`                 | Port to expose for firezone web service. | `13000`     |

### Firezone vpn traffic service configuration.

| Name                                             | Description                                                        | Value       |
| ------------------------------------------------ | ------------------------------------------------------------------ | ----------- |
| `firezone.servicewireguard.metadata.name`        | firezone vpn traffic service name (Optional).                      | `""`        |
| `firezone.servicewireguard.metadata.labels`      | Extra labels for firezone vpn traffic service.                     | `{}`        |
| `firezone.servicewireguard.metadata.annotations` | Annotations for firezone vpn traffic service.                      | `{}`        |
| `firezone.servicewireguard.type`                 | firezone vpn traffic service type.                                 | `ClusterIP` |
| `firezone.servicewireguard.loadBalancerClass`    | LoadbalancerClass for vpn traffic service If type is LoadBalancer. | `nil`       |
| `firezone.servicewireguard.port`                 | Port to expose for firezone vpn traffic service.                   | `51820`     |

### Firezone Ingress Specifies settings for the Kubernetes Ingress resource.

| Name                              | Description                                                                                      | Value              |
| --------------------------------- | ------------------------------------------------------------------------------------------------ | ------------------ |
| `firezone.ingress.enabled`        | To enable or disable ingress.                                                                    | `false`            |
| `firezone.ingress.className`      | Ingress Class name.                                                                              | `nginx`            |
| `firezone.ingress.name`           | Ingress name.                                                                                    | `""`               |
| `firezone.ingress.labels`         | Ingress resource labels.                                                                         | `{}`               |
| `firezone.ingress.annotations`    | Ingress resource annotations.                                                                    | `{}`               |
| `firezone.ingress.host`           | Application hostname.                                                                            | `example.host`     |
| `firezone.ingress.tls.hosts`      | To Application hostname in TLS settings.                                                         | `["example.host"]` |
| `firezone.ingress.tls.enabled`    | To enable or disable TLS                                                                         | `false`            |
| `firezone.ingress.tls.secretName` | TLS secret name of the ingress. If enabled and no secretName specified, new one will be created. | `""`               |

### Secret for Firezone.

| Name                                | Description                                        | Value                  |
| ----------------------------------- | -------------------------------------------------- | ---------------------- |
| `firezone.secret.name`              | firezone secret name.                              | `""`                   |
| `firezone.secret.labels`            | firezone secret labels.                            | `{}`                   |
| `firezone.secret.annotations`       | firezone secret annotations.                       | `{}`                   |
| `firezone.secret.data.EXTERNAL_URL` | firezone secret data EXTERNAL_URL always required. | `https://example.host` |
| `firezone.secret.override`          | If You want to change default values.              | `[]`                   |

If you want to change default values use `override` block.

You can generate vales with this command. `docker run --rm firezone/firezone bin/gen-env > .env`

Example with override.

```yaml
  secret:
    name: "firezone"
    labels: {}
    annotations: {}  
    data: []
    override:
      EXTERNAL_URL: https://example.host
      VERSION: value from .env file
      DEFAULT_ADMIN_EMAIL: value from .env file
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

### Firezone Persistence Volume.

If disabled you can lost VPN configuration after pod restart.

| Name                                    | Description                                                                        | Value               |
| --------------------------------------- | ---------------------------------------------------------------------------------- | ------------------- |
| `firezone.persistence.type`             | persistence type.                                                                  | `pvc`               |
| `firezone.persistence.enabled`          | For enable/disable persisyence(If desabled You can loss data after pod restarting) | `true`              |
| `firezone.persistence.storageClassName` | Storage class name.                                                                | `efs-sc`            |
| `firezone.persistence.accessModes`      | Access modes for storage.                                                          | `["ReadWriteOnce"]` |
| `firezone.persistence.size`             | Persistence volume size.                                                           | `10Gi`              |


### Firezone postgres db statefulset.

| Name                                     | Description                                                                           | Value          |
| ---------------------------------------- | ------------------------------------------------------------------------------------- | -------------- |
| `postgres.stateful.metadata.name`        | postgres statedulset name (Optional).                                                 | `""`           |
| `postgres.stateful.metadata.labels`      | Annotations for postgres statefulset.                                                 | `{}`           |
| `postgres.stateful.metadata.annotations` | Extra labels for statefulset.                                                         | `{}`           |
| `postgres.replicaCount`                  | The number of replicas (instances) of the application that should be running          | `1`            |
| `postgres.image.registry`                | Specifies The Container image registry.                                               | `library`      |
| `postgres.image.repository`              | Specifies the Container image to use for the application and its associated settings. | `""`           |
| `postgres.image.pullPolicy`              | Specifies the Image PullPolicy.                                                       | `IfNotPresent` |
| `postgres.image.tag`                     | Overrides the image tag whose default is the chart appVersion.                        | `""`           |
| `postgres.resources.limits.cpu`          | Resources limit for cpu.                                                              | `""`           |
| `postgres.resources.limits.memory`       | Resources limits for memory.                                                          | `""`           |
| `postgres.resources.requests.cpu`        | Resources requests for cpu.                                                           | `""`           |
| `postgres.resources.requests.memory`     | Resources requests for memory.                                                        | `""`           |

### Postgres Node Selectors, Tolerations, Affinities. 

| Name                    | Description                                                            | Value |
| ----------------------- | ---------------------------------------------------------------------- | ----- |
| `postgres.nodeSelector` | Specifies settings for node selection when scheduling pods.            | `{}`  |
| `postgres.tolerations`  | Specifies Kubernetes tolerations for the pods created by the chart.    | `[]`  |
| `postgres.affinity`     | Specifies Kubernetes affinity rules for the pods created by the chart. | `{}`  |

### Postgres db service configuration.

| Name                                    | Description                             | Value       |
| --------------------------------------- | --------------------------------------- | ----------- |
| `postgres.service.metadata.name`        | postgres db service name (Optional).    | `""`        |
| `postgres.service.metadata.labels`      | Extra labels for postgres db service.   | `{}`        |
| `postgres.service.metadata.annotations` | Annotations for postgres db service.    | `{}`        |
| `postgres.service.type`                 | postgres dbservice type.                | `ClusterIP` |
| `postgres.service.port`                 | Port to expose for postgres db service. | `5432`      |

### Secret for Postgres.

| Name                          | Description                  | Value |
| ----------------------------- | ---------------------------- | ----- |
| `postgres.secret.name`        | postgres secret name.        | `""`  |
| `postgres.secret.labels`      | postgres secret labels.      | `{}`  |
| `postgres.secret.annotations` | postgres secret annotations. | `{}`  |
| `postgres.secret.data`        | postgres secret data.        | `[]`  |

If You override values in `Firezone Secret to custom`, then required to add value `DATABASE_PASSWORD` from `.env` in data section.

Example

```yaml
  secret:
    name: ""
    labels: {}
    annotations: {}
    data: 
      POSTGRES_PASSWORD: DATABASE_PASSWORD value from .env file
```

### Postgres Persistence Volume.

If disabled you can lost data after pod restart.

| Name                                    | Description                                                                        | Value               |
| --------------------------------------- | ---------------------------------------------------------------------------------- | ------------------- |
| `postgres.persistence.type`             | persistence type.                                                                  | `pvc`               |
| `postgres.persistence.enabled`          | For enable/disable persisyence(If desabled You can loss data after pod restarting) | `true`              |
| `postgres.persistence.storageClassName` | Storage class name.                                                                | `efs-sc`            |
| `postgres.persistence.accessModes`      | Access modes for storage.                                                          | `["ReadWriteOnce"]` |
| `postgres.persistence.size`             | Persistence volume size.                                                           | `10Gi`              |



