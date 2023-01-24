{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "leantime.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "leantime.fullname" -}}
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
{{- define "leantime.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "leantime.labels" -}}
helm.sh/chart: {{ include "leantime.chart" . }}
{{ include "leantime.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "leantime.selectorLabels" -}}
app.kubernetes.io/name: {{ include "leantime.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "leantime.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "leantime.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Select the right database secret
*/}}
{{- define "leantime.databaseSecret" -}}
{{- if eq .Values.internalDatabase.enabled .Values.externalDatabase.enabled }}
{{- required "Select either internal or external database" nil }}
{{- end }}
{{- if eq .Values.internalDatabase.enabled true }}
{{- default (include "leantime.fullname" .) .Values.internalDatabase.existingSecret }}
{{- else }}
{{- default (include "leantime.fullname" .) .Values.externalDatabase.existingSecret }}
{{- end }}
{{- end }}

{{- define "leantime.databaseHost" -}}
{{- if eq .Values.internalDatabase.enabled true }}127.0.0.1
{{- else }}
{{- required "Host is required for external database" .Values.externalDatabase.host }}
{{- end }}
{{- end }}

{{- define "leantime.databasePort" -}}
{{- if eq .Values.internalDatabase.enabled true }}
  {{- .Values.internalDatabase.port }}
{{- else }}
  {{- .Values.externalDatabase.port }}
{{- end }}
{{- end }}

{{- define "leantime.database" -}}
{{- if eq .Values.internalDatabase.enabled true }}leantime
{{- else }}
{{- .Values.externalDatabase.database }}
{{- end }}
{{- end }}

{{- define "leantime.url" -}}
{{- if .Values.leantime.url }}
  {{- .Values.leantime.url }}
{{- else if .Values.ingress.enabled }}http{{ if $.Values.ingress.tls }}s{{ end }}://{{ .Values.ingress.host }}
{{- else if .Values.ingressRoute.enabled }}http{{ if $.Values.ingressRoute.tls }}s{{ end }}://{{ .Values.ingressRoute.host }}
{{- end }}
{{- end }}