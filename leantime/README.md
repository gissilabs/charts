# Gissilabs Helm Charts

## Leantime

Leantime is a lean project management system for innovators. Designed to help you manage your projects from ideation to delivery. For more information, check the project site at <https://leantime.io/>

## Helm Chart

The default installation will deploy one Leantime instance using an internal MariaDB database without persistence. All data will be lost if the pod is deleted or scheduled to a different node.

```bash
helm install myleantime gissilabs/leantime
```

See options below to customize the deployment.

## **Database**

Option | Description | Format | Default
------ | ----------- | ------ | -------
internalDatabase.enabled | Run a MariaDB container in the pod| true / false | true
internalDatabase.port | Database listener port | Number | 3306
internalDatabase.user | Database username | Text | leantime
internalDatabase.password | Database user password | Text | Randomly Generated\*
internalDatabase.rootPassword | Database root password | Text | Randomly Generated\*
internalDatabase.existingSecret | Use existing secret for user, user password and root password. Keys are 'database-user', 'database-password' and 'database-root' | Secret name | Not defined
internalDatabase.securityContext | Container-level Security Context | Map | Empty
internalDatabase.resources | Deployment Resources | Map | Empty
internalDatabase.extraEnv | Inject custom environment variables. Use carefully. | array of env variables | Empty
internalDatabase.image | See **Image** ||
internalDatabase.persistence | See **Storage** ||
|||
externalDatabase.enabled | Use External database | true / false | false
externalDatabase.host | Database hostname. **required** | Hostname | Empty
externalDatabase.database | SQL Database name | Text | leantime
externalDatabase.port | Database listener port | Number | 3306
externalDatabase.existingSecret | Use existing secret for database credentials. Keys are 'database-user' and 'database-password' | Secret name | Not defined
externalDatabase.user | Database username. **required** unless using existing secret | Text | Empty
externalDatabase.password | Database username. **required** unless using existing secret | Text | Empty

**\* Note**: Auto-generated passwords are overwritten every time the template is rendered but the database only creates credentials on the first run. When upgrading, use "--set" to provide the current passwords otherwise they will not match and application will fail.

## **Main application**

Option | Description | Format | Default
------ | ----------- | ------ | -------
leantime.name | Site name | Text | Leantime
leantime.language | Site language | \[2-digit language\]-\[2-digit country\] | en-US
leantime.primaryColor | Main color | #6-digit RGB hex | #1B75BB
leantime.secondaryColor | Secondary color | #6-digit RGB hex | #81B1A8
leantime.defaultTheme | Default site theme | Text | default
leantime.keepTheme | Keep theme and language from previous user for login screen | true / false | true
leantime.logo | Site logo image path | File path | Logo at /images/logo.svg
leantime.printLogo | Site logo image path for printing, must be jpg or png | File path | /images/logo.jpg
leantime.defaultTimezone | Default Timezone | Text [list](https://www.php.net/manual/en/timezones.php) | America/Los_Angeles
leantime.url | Base URL | Full URL (protocol://host.domain.tld) | Empty. If using Ingress or IngressRoute, URL is generated automatically
leantime.sessionExpiration | Session expiration | Number of seconds | 28800 (8hrs)
leantime.sessionSalt | Session salt | Text | Randomly generated
leantime.projectMenu | Allow per-project menu | true / false | false
leantime.debug | Enable debug | 0 (Disabled) or 1 (Enabled) | 0 (Disabled)
leantime.existingSecret | Use existing secret for session salt. Key is 'session-salt' | Secret name | Not defined

## **Application Features**

Option | Description | Format | Default
------ | ----------- | ------ | -------
leantime.s3.enabled | Enable S3 File storage | true / false | false
leantime.s3.endpoint | custom https endpoint | empty or https url| empty
leantime.s3.usePathStyleEndpoint | switch between path or subdomain style endpoint url | true / false | false
leantime.s3.key | S3 Key **(required)** | Text | Empty
leantime.s3.secret | S3 Secret **(required)** | Text | Empty
leantime.s3.bucket | S3 Bucket **(required)** | Text | Empty
leantime.s3.region | S3 Region **(required)** | Text | Empty
leantime.s3.folder | Use sub-folder | Path | Empty
leantime.s3.existingSecret | Use existing secret for S3 key and secret. Keys are 's3-key' and 's3-secret' | Secret name | Not defined
|||
leantime.smtp.enabled | Enable SMTP support | true / false | false
leantime.smtp.from | E-mail sender address **(required)** | e-mail | Empty
leantime.smtp.host | SMTP server **(required)** | hostname | Empty
leantime.smtp.auth | SMTP requires authentication? | true / false | true
leantime.smtp.user | SMTP username **(required)** unless existing secret is used or auth is disabled | Text | Empty
leantime.smtp.password | SMTP password **(required)** unless existing secret is used or auth is disabled | Text | Empty
leantime.smtp.existingSecret | Use existing secret for SMTP username and password. Keys are 'smtp-user' and 'smtp-password' | Secret name | Not defined
leantime.smtp.port | Use non-standard SMTP port | Number | Default SMTP ports
leantime.smtp.secureProtocol | Force specific security protocol | tls, ssl or starttls | Auto-detect
leantime.smtp.autoTLS | Enable TLS automatically if supported by server | true / false | true
leantime.smtp.insecureSSL | Allow insecure SSL: Don't verify certificate, accept self-signed, etc. | true / false | false
|||
leantime.ldap.enabled | Enable LDAP support | true / false | false
leantime.ldap.uri | LDAP URI | ldap[s]://hostname:port | Empty
leantime.ldap.host | LDAP server required if URI is not set | hostname| Empty
leantime.ldap.port | LDAP listener port | Number | 389
leantime.ldap.userDN | DN to search users **(required)** | DN (e.g. CN=users,DC=example,DC=com) | Empty
leantime.ldap.domain | LDAP domain to append on usernames | Domain name (e.g. example.com) | Empty
leantime.ldap.type | LDAP server type | OL (OpenLDAP) or AD (Active Directory) | OL
leantime.ldap.keys | Mapping of user fields with LDAP user attributes | JSON | OL attributes (uid, memberof, mail and displayname)
leantime.ldap.groupRoles | Mapping of user role with LDAP group | JSON | Owner access to "Administrators"
leantime.ldap.defaultRole | Default role if no mapped group is found | Number | 20 (Editor)
|||
leantime.oidc.enabled | Enable OIDC support | true / false | false
leantime.oidc.clientId | Client ID **(required)** unless existing secret is used | Text | Empty
leantime.oidc.clientSecret | Client Secret **(required)** unless existing secret is used | Text | Empty
leantime.oidc.providerUrl | Provider URL **(required)** | Text | Empty
leantime.oidc.createUser | reate Leantime user if it doesn't exist, otherwise fail login | true / false | false
leantime.oidc.defaultRole | Default role for users created via OIDC | Number | 20 (Editor)
leantime.oidc.existingSecret | Use existing secret for OIDC client id and secret. Keys are 'oidc-client-id' and 'oidc-client-secret' | Secret name | Not defined
leantime.oidc.overrides.authUrl | Auth URL | URL | Empty
leantime.oidc.overrides.tokenUrl | Token URL | URL | Empty
leantime.oidc.overrides.jwksUrl | JSON Web Key Sets URL | URL | Empty
leantime.oidc.overrides.userInfoUrl | User Info URL | URL | Empty
leantime.oidc.overrides.certificateString | Certificate String | Text | Empty
leantime.oidc.overrides.certificateFile | Certificate File | Text | Empty
leantime.oidc.overrides.scopes | OIDC Scopes | Text | Empty
leantime.oidc.overrides.fields.email | Email | Text | Empty
leantime.oidc.overrides.fields.firstName | First Name | Text | Empty
leantime.oidc.overrides.fields.lastName | Last Name | Text | Empty
leantime.oidc.overrides.fields.phone | Phone | Text |Empty
leantime.oidc.overrides.fields.jobTitle | Job Title | Text | Empty
leantime.oidc.overrides.fields.jobLevel | Job Level | Text | Empty
leantime.oidc.overrides.fields.department | Department | Text | Empty
|||
leantime.redis.enabled | Enable Redis support | true / false | false
leantime.redis.uri | Redis URL **(required)**. Include "?auth=" followed by password if authentication is enabled. | tcp://hostname:port | Empty
|||
leantime.extraEnv | custom env variables to be more flexible with custom images | array of env variables | Empty

## **Network**

Option | Description | Format | Default
------ | ----------- | ------ | -------
service.type | Service Type. [More Information](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types) | Type | ClusterIP
service.port | Service port for HTTP server | Number | 80
service.externalTrafficPolicy | External Traffic Policy. [More Information](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) | Local / Cluster| Cluster
service.loadBalancerIP | Manually select IP when type is LoadBalancer | IP address | Not defined
service.nodePorts.http | Manually select node port for http | Number | Empty
|||
ingress.enabled | Enable Ingress | true / false | false
ingress.host | Ingress hostname **required** | Hostname | Empty
ingress.annotations | Ingress annotations | Map | Empty
ingress.tls | Ingress TLS options | Array of Maps | Empty
|||
ingressRoute.enabled | Enable Traefik IngressRoute CRD | true / false | false
ingressRoute.newCRD | Traefik 2.10 and above uses a new CRD namespace (traefik.io) | true / false | false
ingressRoute.host | Ingress route hostname **required** | Hostname | Empty
ingressRoute.entrypoints | List of Traefik endpoints | Array of Text | \[websecure\]
ingressRoute.tls | Ingress route TLS options | Map | Empty

## **Storage**

**Note**: If persistance is not enabled, data will be held on "Empty Dir" which is created on the first time the Pod runs on a node. If Pod is deleted or moved to another node, data will be lost.

Option | Description | Format | Default
------ | ----------- | ------ | -------
persistence.enabled | Use persistent volume (PVC) for user files. Uses sub-paths 'userfiles' and 'public-userfiles' | true / false | false
persistence.size | Size of volume | Size | 1Gi
persistence.accessMode | Volume access mode | Text | ReadWriteOnce
persistence.storageClass | Storage Class | Text | Not defined. Use "-" for default class
persistence.existingClaim | Use existing PVC | Name of PVC | Not defined
additionalVolumes | Additional volumes definitions, to be used by sidecars [Spec](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#volumes) | Array | Empty
|||
sessionstorage.enabled | Use persistent volume (PVC) for user sessions. Mounts to /sessions | true / false | false
sessionstorage.size | Size of volume | Size | 1Gi
persissessionstoragetence.accessMode | Volume access mode | Text | ReadWriteOnce
sessionstorage.storageClass | Storage Class | Text | Not defined. Use "-" for default class
sessionstorage.existingClaim | Use existing PVC | Name of PVC | Not defined
|||
internalDatabase.persistence.enabled | Use persistent volume (PVC) for MariaDB database | true / false | false
internalDatabase.persistence.size | Size of volume | Size | 2Gi
internalDatabase.persistence.accessMode | Volume access mode | Text | ReadWriteOnce
internalDatabase.persistence.storageClass | Storage Class | Text | Not defined. Use "-" for default class
internalDatabase.persistence.existingClaim | Use existing PVC | Name of PVC | Not defined

## **Image**

Option | Description | Format | Default
------ | ----------- | ------ | -------
image.repository | Leantime Docker image | Text | leantime/leantime
image.tag | Docker image tag | Text | Empty. Uses appVersion from Chart
image.pullPolicy | Image pull policy. [More Information](https://kubernetes.io/docs/concepts/configuration/overview/#container-images) | Text | IfNotPresent
|||
internalDatabase.image.repository | MariaDB Docker image | Text | mariadb
internalDatabase.image.tag | MariaDB image tag | Text | 10.3.23 (newer versions could be affected by a [bug](https://github.com/docker-library/mariadb/issues/262) if using slow disks)
internalDatabase.image.pullPolicy | Image pull policy. [More Information](https://kubernetes.io/docs/concepts/configuration/overview/#container-images) | Text | IfNotPresent
imagePullSecrets | Image pull secrets | Array | Empty

## **General Kubernetes/Helm**

Option | Description | Format | Default
------ | ----------- | ------ | -------
strategy | Deployment Strategy options | sub-tree | Empty
replicaCount | Number of pod replicas | Number | 1
nameOverride | Name override | Text | Empty
fullnameOverride | Full name override | Text | Empty
serviceAccount.create | Create Service Account | true / false | false
serviceAccount.annotations | Annotations service account | Map | Empty
serviceAccount.name | Service Account name | Text | Generated from template
deploymentAnnotations | Deployment Annotations | Map | Empty
probes.liveness | Liveness options [Spec](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes) | Map | Empty
probes.readiness | Readiness options [Spec](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes) | Map | Empty
sidecars | Sidecar container definition [Spec](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#Container) | Array | Empty
podAnnotations | Pod Annotations | Map | Empty
podLabels | Extra Pod Labels | Map | Empty
podSecurityContext | Pod-level Security Context | Map | Empty
securityContext | Container-level Security Context | Map | Empty
resources | Deployment Resources | Map | Empty
nodeSelector | Node selector | Map | Empty
tolerations | Tolerations | Array | Empty
affinity | Affinity | Map | Empty

## Upgrade

### From 1.0 to 1.1

The internal MariaDB database now defaults to 10.6.x from 10.3.x. On the first run using the new version, it is recommended to add ```MARIADB_AUTO_UPGRADE: 1``` via internalDatabase.extraEnv to run system upgrades.

### From 0.x to 1.x

On Leantime 2.2.4, the theme color changed to support primary and secondary colors. As a result the option ```leantime.color``` was deprecated in favor of ```leantime.primaryColor``` and ```leantime.secondaryColor```.
