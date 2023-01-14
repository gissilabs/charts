{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "vaultwarden.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "vaultwarden.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "vaultwarden.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "vaultwarden.labels" -}}
helm.sh/chart: {{ include "vaultwarden.chart" . }}
{{ include "vaultwarden.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "vaultwarden.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vaultwarden.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "vaultwarden.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "vaultwarden.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Ensure valid DB type is select, defaults to SQLite
*/}}
{{- define "vaultwarden.dbTypeValid" -}}
{{- if not (or (eq .Values.database.type "postgresql") (eq .Values.database.type "mysql") (eq .Values.database.type "sqlite")) }}
{{- required "Invalid database type" nil }}
{{- end -}}
{{- end -}}

{{/*
Ensure log type is valid
*/}}
{{- define "vaultwarden.logLevelValid" -}}
{{- if not (or (eq .Values.vaultwarden.log.level "trace") (eq .Values.vaultwarden.log.level "debug") (eq .Values.vaultwarden.log.level "info") (eq .Values.vaultwarden.log.level "warn") (eq .Values.vaultwarden.log.level "error") (eq .Values.vaultwarden.log.level "off")) }}
{{- required "Invalid log level" nil }}
{{- end }}
{{- end }}

{{/*
Ensure SMTP Security setting is valid
*/}}

{{- define "vaultwarden.smtpSecurityValid" -}}
{{- if or (hasKey .Values.vaultwarden.smtp "ssl") (hasKey .Values.vaultwarden.smtp "explicitTLS") }}
{{- required "SMTP options ssl and explicitTLS are deprecated for Vaulwarden 1.25 or newer, see documentation" nil }}
{{- end }}
{{- if not (or (eq .Values.vaultwarden.smtp.security "off") (eq .Values.vaultwarden.smtp.security "starttls") (eq .Values.vaultwarden.smtp.security "force_tls") ) }}
{{- required "Invalid SMTP security setting, valid options are: off, starttls and force_tls" nil }}
{{- end }}
{{- end }}


{{- define "vaultwarden.domainSubPath" -}}
{{- if .Values.vaultwarden.domain }}
{{- if not (regexMatch "https?:\\/\\/.*?(\\/|$)" .Values.vaultwarden.domain) }}
{{- required "Invalid domain, must start with http or https" nil }}
{{- end }}
{{- $subpath := regexReplaceAll "https?:\\/\\/.*?(\\/|$)" .Values.vaultwarden.domain "" -}}/{{ $subpath }}
{{- else }}/
{{- end }}
{{- end -}}