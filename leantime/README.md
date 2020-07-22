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
internalDatabase.image | See **Image** ||
internalDatabase.persistence | See **Storage** ||
|||
externalDatabase.enabled | Use External database | true / false | false
externalDatabase.host | Database hostname. **required** | Hostname | Empty
externalDatabase.database | SQL Database name | Text | leantime
externalDatabase.existingSecret | Use existing secret for database credentials. Keys are 'database-user' and 'database-password' | Secret name | Not defined
externalDatabase.user | Database username. **required** unless using existing secret | Text | Empty
externalDatabase.password | Database username. **required** unless using existing secret | Text | Empty

**\* Note**: Auto-generated passwords are overwritten every time the template is rendered but the database only creates credentials on the first run. When upgrading, use "--set" to provide the current passwords otherwise they will not match and application will fail.

## **Main application**

Option | Description | Format | Default
------ | ----------- | ------ | -------
leantime.name | Site name | Text | Leantime
leantime.language | Site language | \[2-digit language\]-\[2-digit country\] | en-US
leantime.color | Main color | 6-digit RGB hex | 1b75bb
leantime.logo | Site logo image path | File path | Logo at /images/logo.png
leantime.url | Base URL | Full URL (protocol://host.domain.tld) | Empty. If using Ingress or IngressRoute, URL is generated automatically
leantime.sessionExpiration | Session expiration | Number of seconds | 28800 (8hrs)
leantime.sessionSalt | Session salt | Text | Randomly generated
leantime.existingSecret | Use existing secret for session salt. Key is 'session-salt' | Secret name | Not defined

## **Application Features**

Option | Description | Format | Default
------ | ----------- | ------ | -------
leantime.s3.enabled | Enable S3 File storage | true / false | false
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
leantime.smtp.user | SMTP username **(required)** unless existing secret is used | Text | Empty
leantime.smtp.password | SMTP password **(required)** unless existing secret is used | Text | Empty
leantime.smtp.existingSecret | Use existing secret for SMTP username and password. Keys are 'smtp-user' and 'smtp-password' | Secret name | Not defined
leantime.smtp.port | Use non-standard SMTP port | Number | Default SMTP ports
leantime.smtp.secureProtocol | Force specific security protocol | tls, ssl or starttls | Auto-detect
leantime.smtp.autoTLS | Enable TLS automatically if supported by server | true / false | true

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
podAnnotations | Pod Annotations | Map | Empty
podSecurityContext | Pod-level Security Context | Map | Empty
securityContext | Container-level Security Context | Map | Empty
resources | Deployment Resources | Map | Empty
nodeSelector | Node selector | Map | Empty
tolerations | Tolerations | Array | Empty
affinity | Affinity | Map | Empty
