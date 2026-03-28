# Gissilabs Helm Charts - vaultwarden

![Version: 1.3.0](https://img.shields.io/badge/Version-1.3.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.34.3](https://img.shields.io/badge/AppVersion-1.34.3-informational?style=flat-square)

Unofficial Bitwarden compatible server written in Rust

**Homepage:** <https://github.com/dani-garcia/vaultwarden>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Silvio Gissi | <silvio@gissilabs.com> |  |

## Source Code

* <https://github.com/dani-garcia/vaultwarden>

## Vaultwarden

Vaultwarden is an unofficial Bitwarden compatible server written in Rust. For more information, check the project on Github: <https://github.com/dani-garcia/vaultwarden>

## Installation

The default installation will deploy one Vaultwarden instance using a SQLite database without persistence. All data will be lost if the pod is deleted.

```bash
# Add the Gissilabs repository if not already added
helm repo add gissilabs https://gissilabs.github.io/charts/
helm repo update

# Install the chart
helm install myvaultwarden gissilabs/vaultwarden
```

See options below to customize the deployment.

## **Database**

Option | Description | Format | Default
------ | ----------- | ------ | -------
database.type | Backend database type | sqlite, mysql or postgresql | sqlite
database.wal | Enable SQLite Write-Ahead-Log, ignored for external databases | true / false | true
database.url | URL of external database (MySQL/PostgreSQL) | \[mysql\|postgresql\]://user:pass@host:port\[/database\] | Empty
database.existingSecret | Use existing secret for database URL, key 'database-url' | Secret name  | Not defined
database.existingSecretKey | Use different key for existing secret for database URL. If defined, `database.existingSecret` has to be defined as well | Secret name | Not defined
database.maxConnections | Set the size of the database connection pool | Number  | 10
database.retries | Connection retries during startup, 0 for infinite. 1 second between retries | Number | 15

## **Main application**

Option | Description | Format | Default
------ | ----------- | ------ | -------
vaultwarden.domain | Bitwarden URL. Mandatory for invitations over email | http\[s\]://hostname | Not defined
vaultwarden.allowSignups | Allow any user to sign-up. [More information](https://github.com/dani-garcia/vaultwarden/wiki/Disable-registration-of-new-users) | true / false | true
vaultwarden.signupDomains | Whitelist domains allowed to sign-up. 'allowSignups' is ignored if set | domain1,domain2 | Not defined
vaultwarden.verifySignup | Verify e-mail before login is enabled. SMTP must be enabled | true / false | false
vaultwarden.requireEmail | Require that an e-mail is sucessfully sent before login. SMTP must be enabled | true / false | false
vaultwarden.emailAttempts | Maximum attempts before an email token is reset and a new email will need to be sent | Number | 3
vaultwarden.emailTokenExpiration | Email token validity in seconds | Number | 600
vaultwarden.allowInvitation | Allow invited users to sign-up even feature is disabled. [More information](https://github.com/dani-garcia/vaultwarden/wiki/Disable-invitations) | true / false | true
vaultwarden.invitationExpiration | Number of hours after which tokens expire (organization invite, emergency access, email verification and deletion request | Number (minimum 1) | 120
vaultwarden.defaultInviteName | Default organization name in invitation e-mails that are not coming from a specific organization. | Text | Vaultwarden
vaultwarden.passwordHintsAllowed | Allow users to set password hints. Applies to all users. | true / false | true
vaultwarden.showPasswordHint | Show password hints. [More Information](https://github.com/dani-garcia/vaultwarden/wiki/Password-hint-display) | true / false | false
vaultwarden.enableWebVault | Enable Web Vault static site. [More Information](https://github.com/dani-garcia/vaultwarden/wiki/Disabling-or-overriding-the-Vault-interface-hosting). | true / false | true
vaultwarden.enableSends | Enable Bitwarden Sends globally. | true / false | true
vaultwarden.orgCreationUsers | Restrict creation of orgs. | 'all', 'none' or a comma-separated list of users. | all
vaultwarden.attachmentLimitOrg | Limit attachment disk usage in Kb per organization | Number | Not defined
vaultwarden.attachmentLimitUser | Limit attachment disk usage in Kb per user | Number | Not defined
vaultwarden.sendLimitUser | Limit send disk usage in Kb per user | Number | Not defined
vaultwarden.hibpApiKey | API Key to use HaveIBeenPwned service. Can be purchased at [here](https://haveibeenpwned.com/API/Key) | Text | Not defined
vaultwarden.autoDeleteDays | Number of days to auto-delete trashed items. | Number | Empty (never auto-delete)
vaultwarden.orgEvents | Enable Organization event logging | true / false | false
vaultwarden.orgEventsRetention | Organization event log retention in days | Number | Empty (never delete)
vaultwarden.emailChangeAllowed | Allow users to change their email. | true / false | true
vaultwarden.extraEnv | Pass extra environment variables, either as key-value pairs or as key-reference pairs | Map | Not defined
vaultwarden.log.file | Filename to log to disk. [More information](https://github.com/dani-garcia/vaultwarden/wiki/Logging) | File path | Empty
vaultwarden.log.level | Change log level | trace, debug, info, warn, error or off | Empty
vaultwarden.log.timeFormat | Log timestamp | Rust chrono [format](https://docs.rs/chrono/0.4.15/chrono/format/strftime/index.html). | Empty

## **Application Features**

:warning: SMTP SSL/TLS settings changed following Vaultwarden v1.25 release, see [Upgrade](#upgrade)

Option | Description | Format | Default
------ | ----------- | ------ | -------
vaultwarden.admin.enabled | Enable admin portal. Change settings in the portal will overwrite chart options. | true / false | false
vaultwarden.admin.disableAdminToken | Disabling the admin token will make the admin portal accessible to anyone, use carefully. [More Information](https://github.com/dani-garcia/vaultwarden/wiki/Disable-admin-token) | true / false | false
vaultwarden.admin.token | Token for admin login, will be generated if not defined. [More Information](https://github.com/dani-garcia/vaultwarden/wiki/Enabling-admin-page) | Text | Auto-generated
vaultwarden.admin.existingSecret | Use existing secret for the admin token. Key is 'admin-token' | Secret name | Not defined
|||
vaultwarden.emergency.enabled | Allow any user to enable emergency access. | true / false | true
vaultwarden.emergency.reminder | Schedule to send expiration reminders to emergency access grantors. | Cron schedule format, blank to disable | "0 3 \* \* \* \*" (hourly 3 minutes after the hour)
vaultwarden.emergency.timeout | Schedule to grant emergency access requests that have met the required wait time. | Cron schedule format, blank to disable | "0 3 \* \* \* \*" (hourly 3 minutes after the hour)
|||
vaultwarden.smtp.enabled | Enable SMTP | true / false | false
vaultwarden.smtp.host | SMTP hostname **required** | Hostname | Empty
vaultwarden.smtp.from | SMTP sender e-mail address **required** | E-mail | Empty
vaultwarden.smtp.fromName | SMTP sender name | Text | Vaultwarden
vaultwarden.smtp.security | Set SMTP connection security [More Information](https://github.com/dani-garcia/vaultwarden/wiki/SMTP-Configuration) | starttls / force_tls / off | starttls
vaultwarden.smtp.port | SMTP TCP port | Number | Security off: 25, starttls: 587, force_tls: 465
vaultwarden.smtp.authMechanism | SMTP Authentication Mechanisms | Comma-separated list: 'Plain', 'Login', 'Xoauth2' | Plain
vaultwarden.smtp.heloName | Hostname to be sent for SMTP HELO | Text | Pod name
vaultwarden.smtp.timeout | SMTP connection timeout in seconds | Number | 15
vaultwarden.smtp.invalidHostname | Accept valid certificates even if hostnames does not match. DANGEROUS! | true / false | false
vaultwarden.smtp.invalidCertificate | Accept invalid certificates. DANGEROUS! | true / false | false
vaultwarden.smtp.user | SMTP username | Text | Not defined
vaultwarden.smtp.password | SMTP password. Required is user is specified | Text | Not defined
vaultwarden.smtp.existingSecret | Use existing secret for SMTP authentication. Keys are 'smtp-user' and 'smtp-password' | Secret name | Not defined
vaultwarden.smtp.embedImages | Embed images as email attachments | true / false | true
|||
vaultwarden.yubico.enabled | Enable Yubikey support | true / false | false
vaultwarden.yubico.server | Yubico server | Hostname | YubiCloud
vaultwarden.yubico.clientId | Yubico ID | Text | Not defined
vaultwarden.yubico.secretKey | Yubico Secret Key | Text | Not defined
vaultwarden.yubico.existingSecret | Use existing secret for ID and Secret. Keys are 'yubico-client-id' and 'yubico-secret-key' | Secret name | Not defined
|||
vaultwarden.icons.service | Service to fetch icons from | "internal", "bitwarden", "duckduckgo", "google" or custom URL | internal
vaultwarden.icons.disableDownload | Disables download of external icons, icons in cache will still be served | true / false | false
vaultwarden.icons.cache | Cache time-to-live for icons fetched. 0 means no purging | Number | 2592000. If download is disabled, defaults to 0
vaultwarden.icons.cacheFailed | Cache time-to-live for icons that were not available. 0 means no purging | Number | 2592000
vaultwarden.icons.redirectCode | HTTP code to use for redirects to an external icon service | true / false | 302
|||
vaultwarden.push.enabled | Enable Push notifications | true / false | false
vaultwarden.push.installationId | Installation ID from Bitwarden | Text | Empty
vaultwarden.push.installationKey | Installation Key from Bitwarden | Text | Empty
vaultwarden.push.relayUri | Relay URI, should not need to change | URL | https://push.bitwarden.com
vaultwarden.push.identityUri | Identity URI, should not need to change | URL | https://push.bitwarden.com
vaultwarden.push.existingSecret | Use existing secret for Push notifications. Keys are 'push-id' and 'push-key' | Secret name | Not defined

## **Network**

Option | Description | Format | Default
------ | ----------- | ------ | -------
service.type | Service Type. [More Information](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types) | Type | ClusterIP
service.httpPort | Service port for HTTP server | Number | 80
service.externalTrafficPolicy | External Traffic Policy. [More Information](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) | Local / Cluster| Cluster
service.loadBalancerIP | Manually select IP when type is LoadBalancer | IP address | Not defined
service.nodePorts.http | Manually select node port for http | Number | Empty
|||
ingress.enabled | Enable Ingress | true / false | false
ingress.className | Name of the ingress class | Text | Empty
ingress.host | Ingress hostname **required** | Hostname | Empty
ingress.annotations | Ingress annotations | Map | Empty
ingress.tls | Ingress TLS options | Array of Maps | Empty
|||
ingressRoute.enabled | Enable Traefik IngressRoute CRD | true / false | false
ingressRoute.newCRD | Traefik 2.10 and above uses a new CRD namespace (traefik.io) | true / false | false
ingressRoute.host | Ingress route hostname **required** | Hostname | Empty
ingressRoute.middlewares | Enable middlewares | Map | Empty
ingressRoute.entrypoints | List of Traefik endpoints | Array of Text | \[websecure\]
ingressRoute.tls | Ingress route TLS options | Map | Empty

## **Storage**

Option | Description | Format | Default
------ | ----------- | ------ | -------
persistence.enabled | Create persistent volume (PVC). Holds attachments, icon cache and, if used, the SQLite database | true / false | false
persistence.size | Size of volume | Size | 1Gi
persistence.accessMode | Volume access mode | Text | ReadWriteOnce
persistence.storageClass | Storage Class | Text | Not defined. Use "-" for default class
persistence.existingClaim | Use existing PVC | Name of PVC | Not defined
persistence.annotations | PVC annotations | Map | Empty
customVolume | Use custom volume definition. Cannot be used with persistence | Map | Empty
additionalVolumes | Additional volumes definitions, to be used by sidecars [Spec](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#volumes) | Array | Empty
extraVolumeMounts | Add extra volumeMounts to deployment | Map | Empty
## **Image**

Option | Description | Format | Default
------ | ----------- | ------ | -------
image.tag | Docker image tag | Text | Chart appVersion (Chart.yaml)
image.repository | Docker image | Text | vaultwarden/server
imagePullSecrets | Image pull secrets | Array | Empty

## **General Kubernetes/Helm**

Option | Description | Format | Default
------ | ----------- | ------ | -------
strategy | Deployment Strategy options | sub-tree | Empty
replicaCount | Number of pod replicas | Number | 1
revisionHistoryLimit | revisionHistoryLimit | Number | 10
nameOverride | Name override | Text | Empty
fullnameOverride | Full name override | Text | Empty
serviceAccount.create | Create Service Account | true / false | false
serviceAccount.annotations | Annotations service account | Map | Empty
serviceAccount.name | Service Account name | Text | Generated from template
serviceAccount.automountServiceAccountToken | Allows auto mount of ServiceAccountToken on the serviceAccount created | true / false | true
automountServiceAccountToken | Mount Service Account token in pod | true / false | true
deploymentAnnotations | Deployment Annotations | Map | Empty
probes.liveness | Liveness options [Spec](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes) | Map | Empty
probes.readiness | Readiness options [Spec](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes) | Map | Empty
sidecars | Sidecar container definition [Spec](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#Container) | Array | Empty
podAnnotations | Pod Annotations | Map | Empty
podLabels | Extra Pod Labels | Map | Empty
podSecurityContext | Pod-level Security Context | Map | {fsGroup:65534}
securityContext | Container-level Security Context | Map | {runAsUser:65534, runAsGroup:65534}
resources | Deployment Resources | Map | Empty
nodeSelector | Node selector | Map | Empty
tolerations | Tolerations | Array | Empty
affinity | Affinity | Map | Empty

## Upgrade
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
| persistence.labels | object | `{}` | Additional PVC labels |
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
| service.nodePorts | object | `{"http":0}` | NodePort configuration |
| service.nodePorts.http | int | `0` | HTTP node port |
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
| vaultwarden.emergency.timeout | string | `"0 7 * * * *"` | Schedule to grant emergency access requests (cron format) |
| vaultwarden.enableSends | bool | `true` | Enable Bitwarden Sends globally |
| vaultwarden.enableWebVault | bool | `true` | Enable Web Vault (static content) |
| vaultwarden.extraEnv | object | `{}` | Map of custom environment variables. Use carefully |
| vaultwarden.hibpApiKey | string | `""` | HaveIBeenPwned API Key |
| vaultwarden.icons.cache | string | `"2592000"` | Cache TTL for icons in seconds (0 = no purging) |
| vaultwarden.icons.cacheFailed | string | `"259200"` | Cache TTL for failed icon lookups in seconds (0 = no purging) |
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
