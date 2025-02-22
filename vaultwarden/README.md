# Gissilabs Helm Charts

## Upgrade from bitwardenrs Helm Chart

The upstream project changed its name from bitwarden_rs to Vaultwarden on April 27th, 2021. If you are using the bitwardenrs chart, the following changes are needed to use this chart:

- Change chart name from gissilabs/bitwardenrs to gissilabs/vaultwarden
- If using custom values, update top-level "bitwardenrs" option to "vaultwarden"

Chart and application version numbers are the same across both charts.

## Vaultwarden

Vaultwarden (previously known as bitwarden_rs) is an unofficial Bitwarden compatible server written in Rust. For more information, check the project on Github: <https://github.com/dani-garcia/vaultwarden>

## Helm Chart

The default installation will deploy one Vaultwarden instance using a SQLite database without persistence. All data will be lost if the pod is deleted.

```bash
# Uncomment below if the Gissilabs repository is not yet added to Helm
#helm repo add gissilabs https://gissilabs.github.io/charts/
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

### From 1.1 to 1.2

Dropped support for Ingress on Kubernetes versions 1.18 or older. [More details](https://kubernetes.io/docs/reference/using-api/deprecation-guide/#ingressclass-v122). Since Vaultwarden 1.29, WebSockets no longer uses separate port, support for that has been removed as well.

### From 1.0 to 1.1

The default value for Embed Images on email option changed from false to true.

### From 0.x to 1.x

Vaultwarden version before v1.25.0 had a [bug/mislabelled](https://github.com/dani-garcia/vaultwarden/issues/851) configuration setting regarding SSL and TLS. This has been fixed in testing and newer released versions. When image version is 1.25 or higher, use vaultwarden.smtp.security instead of vaultwarden.smtp.ssl/vaultwarden.smtp.explicitTLS.

ssl | explicitTLS | security equivalent
--- | ----------- | -------------------
false | false | off
false | true | off
true | false | starttls
true | true | force_tls
