# Gissilabs Helm Charts

## bitwarden_rs

Bitwarden_rs is an unofficial Bitwarden compatible server written in Rust. For more information, check the project on Github: <https://github.com/dani-garcia/bitwarden_rs>

## Helm Chart

The default installation will deploy one bitwarden_rs instance using a SQLite database without persistence. All data will be lost if the pod is deleted.

```bash
helm install mybitwardenrs gissilabs/bitwardenrs
```

See options below to customize the deployment.

### **Database**

Option | Description | Format | Default
------ | ----------- | ------ | -------
database.type | Backend database type | sqlite, mysql or postgresql | sqlite
database.wal | Enable SQLite Write-Ahead-Log, ignored for external databases | true / false | true
database.url | URL of external database (MySQL/PostgreSQL) | \[mysql\|postgresql\]://user:pass@host:port | Empty
database.existingSecret | Use existing secret for database URL, key 'database-url' | Secret name  | Not defined

### **Main application**

Option | Description | Format | Default
------ | ----------- | ------ | -------
bitwardenrs.domain | Bitwarden URL. Mandatory for invitations over email | http\[s\]://hostname | Not defined
bitwardenrs.allowSignups | Allow any user to sign-up. [More information](https://github.com/dani-garcia/bitwarden_rs/wiki/Disable-registration-of-new-users) | true / false | true
bitwardenrs.signupDomains | Whitelist domains allowed to sign-up. 'allowSignups' is ignored if set | domain1,domain2 | Not defined
bitwardenrs.verifySignup | Verify e-mail before login is enabled. SMTP must be enabled | true / false | false
bitwardenrs.allowInvitation | Allow invited users to sign-up even feature is disabled. [More information](https://github.com/dani-garcia/bitwarden_rs/wiki/Disable-invitations) | true / false | true
bitwardenrs.showPasswordHint | Show password hints. [More Information](https://github.com/dani-garcia/bitwarden_rs/wiki/Password-hint-display) | true / false | true
bitwardenrs.enableWebsockets | Enable Websockets for notification. [More Information](https://github.com/dani-garcia/bitwarden_rs/wiki/Enabling-WebSocket-notifications). If using Ingress controllers, "notifications/hub" URL is redirected to websocket port | true / false | true
bitwardenrs.log.file | Filename to log to disk. [More information](https://github.com/dani-garcia/bitwarden_rs/wiki/Logging) | File path | Empty
bitwardenrs.log.level | Change log level | trace, debug, info, warn, error or off | Empty

### **Application Features**

Option | Description | Format | Default
------ | ----------- | ------ | -------
bitwardenrs.admin.enabled | Enable admin portal | true / false | false
bitwardenrs.admin.disableAdminToken | Disabling the admin token will make the admin portal accessible to anyone, use carefully. [More Information](https://github.com/dani-garcia/bitwarden_rs/wiki/Disable-admin-token) | true / false | false
bitwardenrs.admin.token | Token for admin login, will be generated if not defined. [More Information](https://github.com/dani-garcia/bitwarden_rs/wiki/Enabling-admin-page) | Text | Auto-generated
bitwardenrs.admin.existingSecret | Use existing secret for the admin token. Key is 'admin-token' | Secret name | Not defined
|||
bitwardenrs.smtp.enabled | Enable SMTP | true / false | false
bitwardenrs.smtp.host | SMTP hostname **required** | Hostname | Empty
bitwardenrs.smtp.from | SMTP sender e-mail address **required** | E-mail | Empty
bitwardenrs.smtp.fromName | SMTP sender name | Text | Bitwarden_RS
bitwardenrs.smtp.ssl | Enable SSL connection | true / false | true
bitwardenrs.smtp.port | SMTP TCP port | Number | SSL Enabled: 587. SSL Disabled: 25
bitwardenrs.smtp.user | SMTP username | Text | Not defined
bitwardenrs.smtp.password | SMTP password. Required is user is specified | Text | Not defined
bitwardenrs.smtp.existingSecret | Use existing secret for SMTP authentication. Keys are 'smtp-user' and 'smtp-password' | Secret name | Not defined
|||
bitwardenrs.yubico.enabled | Enable Yubikey support | true / false | false
bitwardenrs.yubico.server | Yubico server | Hostname | YubiCloud
bitwardenrs.yubico.clientId | Yubico ID | Text | Not defined
bitwardenrs.yubico.secretKey | Yubico Secret Key | Text | Not defined
bitwardenrs.yubico.existingSecret | Use existing secret for ID and Secret. Keys are 'yubico-client-id' and 'yubico-secret-key' | Secret name | Not defined

### **Network options**

Option | Description | Format | Default
------ | ----------- | ------ | -------
service.type | Service Type. [More Information](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types) | Type | ClusterIP
service.httpPort | Service port for HTTP server | Number | 80
service.websocketPort | Service port for Websocket server, if enabled | Number | 3012
service.externalTrafficPolicy | External Traffic Policy. [More Information](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) | Local / Cluster| Cluster
service.loadBalancerIP | Manually select IP when type is LoadBalancer | IP address | Not defined
service.nodePorts.http | Manually select node port for http | Number | Empty
service.nodePorts.websocket | Manually select node port for websocker, if enabled | Number | Empty
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

### **Storage options**

Option | Description | Format | Default
------ | ----------- | ------ | -------
persistence.enabled | Create persistent volume (PVC). Holds attachments, icon cache and, if used, the SQLite database | true / false | false
persistence.size | Size of volume | Size | 1Gi
persistence.accessMode | Volume access mode | Text | ReadWriteOnce
persistence.storageClass | Storage Class | Text | Not defined. Use "-" for default class
persistence.existingClaim | Use existing PVC | Name of PVC | Not defined

### **Image options**

Option | Description | Format | Default
------ | ----------- | ------ | -------
image.tag | Docker image tag | Text | Chart appVersion (Chart.yaml)
image.sqliteRepository | Docker image for SQLite | Text | bitwardenrs/server
image.mysqlRepository | Docker image for MySQL | Text | bitwardenrs/server-mysql
image.postgresqlRepository | Docker image for PostgreSQL | Text | bitwardenrs/server-postgresql
imagePullSecrets | Image pull secrets | Array | Empty

### **General Kubernetes/Helm options**

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
podSecurityContext | Pod-level Security Context | Map | {fsGroup:65534}
securityContext | Container-level Security Context | Map | {runAsUser:65534, runAsGroup:65534}
resources | Deployment Resources | Map | Empty
nodeSelector | Node selector | Map | Empty
tolerations | Tolerations | Array | Empty
affinity | Affinity | Map | Empty
