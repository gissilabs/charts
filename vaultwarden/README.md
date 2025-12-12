# Gissilabs Helm Charts - vaultwarden

![Version: 1.2.6](https://img.shields.io/badge/Version-1.2.6-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.34.3](https://img.shields.io/badge/AppVersion-1.34.3-informational?style=flat-square)

Unofficial Bitwarden compatible server written in Rust

**Homepage:** <https://github.com/dani-garcia/vaultwarden>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Silvio Gissi | <silvio@gissilabs.com> |  |

## Source Code

* <https://github.com/dani-garcia/vaultwarden>

## Upgrade from bitwardenrs Helm Chart

The upstream project changed its name from bitwarden_rs to Vaultwarden on April 27th, 2021. If you are using the bitwardenrs chart, the following changes are needed to use this chart:

- Change chart name from gissilabs/bitwardenrs to gissilabs/vaultwarden
- If using custom values, update top-level "bitwardenrs" option to "vaultwarden"

Chart and application version numbers are the same across both charts.

## Vaultwarden

Vaultwarden (previously known as bitwarden_rs) is an unofficial Bitwarden compatible server written in Rust. For more information, check the project on Github: <https://github.com/dani-garcia/vaultwarden>

## Installation

The default installation will deploy one Vaultwarden instance using a SQLite database without persistence. All data will be lost if the pod is deleted.

```bash
# Add the Gissilabs repository if not already added
helm repo add gissilabs https://gissilabs.github.io/charts/
helm repo update

# Install the chart
helm install myvaultwarden gissilabs/vaultwarden
```

See the configuration section below to customize the deployment.

## Upgrade Notes

### From 1.1 to 1.2

Dropped support for Ingress on Kubernetes versions 1.18 or older. [More details](https://kubernetes.io/docs/reference/using-api/deprecation-guide/#ingressclass-v122). Since Vaultwarden 1.29, WebSockets no longer uses separate port, support for that has been removed as well.

### From 1.0 to 1.1

The default value for Embed Images on email option changed from false to true.

### From 0.x to 1.x

Vaultwarden version before v1.25.0 had a [bug/mislabelled](https://github.com/dani-garcia/vaultwarden/issues/851) configuration setting regarding SSL and TLS. This has been fixed in testing and newer released versions. When image version is 1.25 or higher, use `vaultwarden.smtp.security` instead of `vaultwarden.smtp.ssl`/`vaultwarden.smtp.explicitTLS`.

| ssl | explicitTLS | security equivalent |
| --- | ----------- | ------------------- |
| false | false | off |
| false | true | off |
| true | false | starttls |
| true | true | force_tls |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalVolumes | list | `[]` | Additional volumes for sidecars |
| affinity | object | `{}` | Affinity rules |
| automountServiceAccountToken | bool | `false` | Mount service account token in pod |
| customVolume | object | `{}` | Custom volume definition (cannot be used with persistence) |
| database.existingSecret | string | `""` | Use existing secret for database URL, key 'database-url' |
| database.existingSecretKey | string | `""` | Use a different key for the existing secret for database URL |
| database.maxConnections | int | `10` | Set the size of the database connection pool |
| database.retries | int | `15` | Connection retries during startup, 0 for infinite. 1 second between retries |
| database.type | string | `"sqlite"` | Database type @default sqlite @enum sqlite;mysql;postgresql |
| database.url | string | `""` | URL for external databases (mysql://user:pass@host:port/database-name or postgresql://user:pass@host:port/database-name) |
| database.wal | bool | `true` | Enable DB Write-Ahead-Log for SQLite, disabled for other databases |
| deploymentAnnotations | object | `{}` | Deployment annotations |
| fullnameOverride | string | `""` | Full name override |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"vaultwarden/server"` | Image repository |
| image.tag | string | `""` | Image tag (defaults to Chart appVersion) |
| imagePullSecrets | list | `[]` | Image pull secrets |
| ingress.annotations | object | `{}` | Ingress annotations |
| ingress.className | string | `""` | Ingress class name |
| ingress.enabled | bool | `false` | Enable Ingress |
| ingress.host | string | `""` | Ingress hostname |
| ingress.tls | list | `[]` | TLS configuration |
| ingressRoute.enabled | bool | `false` | Enable Traefik IngressRoute |
| ingressRoute.entrypoints | list | `["websecure"]` | Traefik entrypoints |
| ingressRoute.host | string | `""` | IngressRoute hostname |
| ingressRoute.middlewares | list | `[]` | Traefik middlewares |
| ingressRoute.newCRD | bool | `false` | Use new CRD (Traefik 2.10+, traefik.io namespace) |
| ingressRoute.tls | object | `{}` | TLS configuration |
| initContainers | list | `[]` | Init containers (container spec) |
| nameOverride | string | `""` | Name override |
| nodeSelector | object | `{}` | Node selector |
| persistence.accessMode | string | `"ReadWriteOnce"` | Access mode |
| persistence.annotations | object | `{}` | PVC annotations |
| persistence.enabled | bool | `false` | Enable persistent storage |
| persistence.existingClaim | string | `""` | Use existing PVC |
| persistence.size | string | `"1Gi"` | PVC size |
| persistence.storageClass | string | `""` | Storage class ("-" for default) |
| podAnnotations | object | `{}` | Pod annotations |
| podLabels | object | `{}` | Pod labels |
| podSecurityContext | object | `{"fsGroup":65534}` | Pod security context |
| probes | object | `{}` | Liveness and readiness probe configuration |
| replicaCount | int | `1` | Number of replicas |
| resources | object | `{}` | Resource limits and requests |
| revisionHistoryLimit | int | `10` | Revision history limit |
| securityContext | object | `{"runAsGroup":65534,"runAsUser":65534}` | Container security context |
| service.externalTrafficPolicy | string | `"Cluster"` | External traffic policy |
| service.httpPort | int | `80` | HTTP port |
| service.loadBalancerIP | string | `""` | LoadBalancer IP (when type is LoadBalancer) |
| service.nodePorts | object | `{"http":""}` | NodePort configuration |
| service.nodePorts.http | string | `""` | HTTP node port |
| service.type | string | `"ClusterIP"` | Service type |
| serviceAccount.annotations | object | `{}` | Service account annotations |
| serviceAccount.automountServiceAccountToken | bool | `false` | Auto-mount service account token |
| serviceAccount.create | bool | `false` | Create service account |
| serviceAccount.name | string | `""` | Service account name (generated if not set) |
| sidecars | list | `[]` | Sidecar containers (container spec) |
| strategy | object | `{}` | Deployment strategy |
| tolerations | list | `[]` | Tolerations |
| vaultwarden.admin.disableAdminToken | bool | `false` | Disable admin token (makes portal accessible to anyone, use carefully) |
| vaultwarden.admin.enabled | bool | `false` | Enable admin portal |
| vaultwarden.admin.existingSecret | string | `""` | Use existing secret for the admin token. Key is 'admin-token' |
| vaultwarden.admin.token | string | `""` | Token for admin login, auto-generated if not defined |
| vaultwarden.allowInvitation | bool | `true` | Allow invited users to sign-up even if registration is disabled |
| vaultwarden.allowSignups | bool | `true` | Allow any user to sign-up |
| vaultwarden.attachmentLimitOrg | string | `""` | Limit attachment disk usage per organization (in KB) |
| vaultwarden.attachmentLimitUser | string | `""` | Limit attachment disk usage per user (in KB) |
| vaultwarden.autoDeleteDays | string | `""` | Number of days to auto-delete trashed items |
| vaultwarden.defaultInviteName | string | `""` | Default organization name in invitation e-mails |
| vaultwarden.domain | string | `""` | Set Vaultwarden URL, mandatory for invitations over email. Format: https://name or http://name |
| vaultwarden.emailAttempts | int | `3` | Maximum attempts before an email token is reset |
| vaultwarden.emailChangeAllowed | bool | `true` | Allow users to change their email |
| vaultwarden.emailTokenExpiration | int | `600` | Email token validity in seconds |
| vaultwarden.emergency.enabled | bool | `true` | Allow any user to enable emergency access |
| vaultwarden.emergency.reminder | string | `"0 3 * * * *"` | Schedule to send expiration reminders (cron format) |
| vaultwarden.emergency.timeout | string | `"0 3 * * * *"` | Schedule to grant emergency access requests (cron format) |
| vaultwarden.enableSends | bool | `true` | Enable Bitwarden Sends globally |
| vaultwarden.enableWebVault | bool | `true` | Enable Web Vault (static content) |
| vaultwarden.extraEnv | object | `{}` | Map of custom environment variables. Use carefully |
| vaultwarden.hibpApiKey | string | `""` | HaveIBeenPwned API Key |
| vaultwarden.icons.cache | int | `2592000` | Cache TTL for icons in seconds (0 = no purging) |
| vaultwarden.icons.cacheFailed | int | `259200` | Cache TTL for failed icon lookups in seconds (0 = no purging) |
| vaultwarden.icons.disableDownload | bool | `false` | Disable download of external icons (still serves from cache) |
| vaultwarden.icons.redirectCode | int | `302` | HTTP redirect code for external icon service |
| vaultwarden.icons.service | string | `"internal"` | Icon download service @default internal @enum internal;bitwarden;duckduckgo;google |
| vaultwarden.invitationExpiration | int | `120` | Number of hours after which invitation tokens expire |
| vaultwarden.log.file | string | `""` | Log to file (file path) |
| vaultwarden.log.level | string | `""` | Log level @default "" @enum trace;debug;info;warn;error;off |
| vaultwarden.log.timeFormat | string | `""` | Log timestamp format (chrono strftime format) |
| vaultwarden.orgCreationUsers | string | `"all"` | Restrict creation of orgs. Options: 'all', 'none' or comma-separated list of users |
| vaultwarden.orgEvents | bool | `false` | Enable organization event logging |
| vaultwarden.orgEventsRetention | string | `""` | Organization event retention in days. Empty to not delete |
| vaultwarden.passwordHintsAllowed | bool | `true` | Allow users to set password hints |
| vaultwarden.push.enabled | bool | `false` | Enable push notifications |
| vaultwarden.push.existingSecret | string | `""` | Use existing secret for Push. Keys: 'push-id' and 'push-key' |
| vaultwarden.push.identityUri | string | `""` | Identity URI |
| vaultwarden.push.installationId | string | `""` | Installation ID from Bitwarden |
| vaultwarden.push.installationKey | string | `""` | Installation Key from Bitwarden |
| vaultwarden.push.relayUri | string | `""` | Relay URI |
| vaultwarden.requireEmail | bool | `false` | Require that email is successfully sent before login. SMTP must be enabled |
| vaultwarden.sendLimitUser | string | `""` | Limit send disk usage per user (in KB) |
| vaultwarden.showPasswordHint | bool | `false` | Show password hints |
| vaultwarden.signupDomains | list | `[]` | Whitelist domains allowed to sign-up. 'allowSignups' is ignored if set |
| vaultwarden.smtp.authMechanism | string | `"Plain"` | SMTP Authentication Mechanisms. Comma-separated: 'Plain', 'Login', 'Xoauth2' |
| vaultwarden.smtp.embedImages | bool | `true` | Embed images as email attachments |
| vaultwarden.smtp.enabled | bool | `false` | Enable SMTP |
| vaultwarden.smtp.existingSecret | string | `""` | Use existing secret for SMTP. Keys: 'smtp-user' and 'smtp-password' |
| vaultwarden.smtp.from | string | `""` | SMTP sender e-mail address (required if SMTP is enabled) |
| vaultwarden.smtp.fromName | string | `""` | SMTP sender name |
| vaultwarden.smtp.heloName | string | `""` | Hostname to be sent for SMTP HELO |
| vaultwarden.smtp.host | string | `""` | SMTP hostname (required if SMTP is enabled) |
| vaultwarden.smtp.invalidCertificate | bool | `false` | Accept invalid certificates (DANGEROUS) |
| vaultwarden.smtp.invalidHostname | bool | `false` | Accept valid certificate with mismatched hostname (DANGEROUS) |
| vaultwarden.smtp.password | string | `""` | SMTP password (required if user is specified) |
| vaultwarden.smtp.port | string | `""` | SMTP port. Defaults: 465 for force_tls, 587 for starttls, 25 for off |
| vaultwarden.smtp.security | string | `"starttls"` | SMTP security @default starttls @enum starttls;force_tls;off |
| vaultwarden.smtp.timeout | int | `15` | SMTP timeout in seconds |
| vaultwarden.smtp.user | string | `""` | SMTP username |
| vaultwarden.verifySignup | bool | `false` | Verify e-mail before login is enabled. SMTP must be enabled |
| vaultwarden.yubico.clientId | string | `""` | Yubico Client ID |
| vaultwarden.yubico.enabled | bool | `false` | Enable Yubico OTP authentication |
| vaultwarden.yubico.existingSecret | string | `""` | Use existing secret for Yubico. Keys: 'yubico-client-id' and 'yubico-secret-key' |
| vaultwarden.yubico.secretKey | string | `""` | Yubico Secret Key |
| vaultwarden.yubico.server | string | `""` | Yubico server (defaults to YubiCloud) |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
