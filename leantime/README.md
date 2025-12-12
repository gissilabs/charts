# leantime

![Version: 1.3.0](https://img.shields.io/badge/Version-1.3.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 3.3.3](https://img.shields.io/badge/AppVersion-3.3.3-informational?style=flat-square)

Lean project management system for innovators

**Homepage:** <https://leantime.io/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Silvio Gissi | <silvio@gissilabs.com> |  |

## Source Code

* <https://github.com/Leantime/leantime>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| automountServiceAccountToken | bool | `false` |  |
| deploymentAnnotations | object | `{}` |  |
| externalDatabase.database | string | `"leantime"` |  |
| externalDatabase.enabled | bool | `false` |  |
| externalDatabase.host | string | `""` |  |
| externalDatabase.password | string | `""` |  |
| externalDatabase.port | int | `3306` |  |
| externalDatabase.user | string | `""` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"leantime/leantime"` |  |
| image.tag | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.host | string | `""` |  |
| ingress.tls | list | `[]` |  |
| ingressRoute.enabled | bool | `false` |  |
| ingressRoute.entrypoints[0] | string | `"websecure"` |  |
| ingressRoute.host | string | `""` |  |
| ingressRoute.newCRD | bool | `false` |  |
| ingressRoute.tls | list | `[]` |  |
| initContainers | list | `[]` |  |
| internalDatabase.enabled | bool | `true` |  |
| internalDatabase.image.pullPolicy | string | `"IfNotPresent"` |  |
| internalDatabase.image.repository | string | `"mariadb"` |  |
| internalDatabase.image.tag | string | `"10.6.21"` |  |
| internalDatabase.password | string | `""` |  |
| internalDatabase.persistence.accessMode | string | `"ReadWriteOnce"` |  |
| internalDatabase.persistence.enabled | bool | `false` |  |
| internalDatabase.persistence.size | string | `"2Gi"` |  |
| internalDatabase.port | int | `3306` |  |
| internalDatabase.resources | object | `{}` |  |
| internalDatabase.rootPassword | string | `""` |  |
| internalDatabase.securityContext | object | `{}` |  |
| internalDatabase.user | string | `"leantime"` |  |
| leantime.defaultTheme | string | `""` |  |
| leantime.defaultTimezone | string | `""` |  |
| leantime.language | string | `""` |  |
| leantime.ldap.enabled | bool | `false` |  |
| leantime.ldap.userDN | string | `""` |  |
| leantime.logo | string | `""` |  |
| leantime.name | string | `""` |  |
| leantime.oidc.clientId | string | `""` |  |
| leantime.oidc.clientSecret | string | `""` |  |
| leantime.oidc.enabled | bool | `false` |  |
| leantime.oidc.overrides.fields | string | `nil` |  |
| leantime.oidc.providerUrl | string | `""` |  |
| leantime.primaryColor | string | `""` |  |
| leantime.printLogo | string | `""` |  |
| leantime.ratelimit | object | `{}` |  |
| leantime.redis.enabled | bool | `false` |  |
| leantime.redis.host | string | `""` |  |
| leantime.redis.url | string | `""` |  |
| leantime.s3.bucket | string | `""` |  |
| leantime.s3.enabled | bool | `false` |  |
| leantime.s3.endpoint | string | `""` |  |
| leantime.s3.key | string | `""` |  |
| leantime.s3.region | string | `""` |  |
| leantime.s3.secret | string | `""` |  |
| leantime.s3.usePathStyleEndpoint | bool | `false` |  |
| leantime.secondaryColor | string | `""` |  |
| leantime.sessionSalt | string | `""` |  |
| leantime.smtp.auth | bool | `true` |  |
| leantime.smtp.enabled | bool | `false` |  |
| leantime.smtp.from | string | `""` |  |
| leantime.smtp.host | string | `""` |  |
| leantime.smtp.password | string | `""` |  |
| leantime.smtp.user | string | `""` |  |
| leantime.url | string | `""` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| persistence.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.annotations | object | `{}` |  |
| persistence.enabled | bool | `false` |  |
| persistence.size | string | `"1Gi"` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| probes | object | `{}` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| revisionHistoryLimit | int | `10` |  |
| securityContext | object | `{}` |  |
| service.externalTrafficPolicy | string | `"Cluster"` |  |
| service.nodePorts.http | string | `""` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automountServiceAccountToken | bool | `false` |  |
| serviceAccount.create | bool | `false` |  |
| serviceAccount.name | string | `""` |  |
| sessionstorage.accessMode | string | `"ReadWriteOnce"` |  |
| sessionstorage.enabled | bool | `false` |  |
| sessionstorage.size | string | `"1Gi"` |  |
| sidecars | list | `[]` |  |
| strategy | object | `{}` |  |
| tolerations | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
