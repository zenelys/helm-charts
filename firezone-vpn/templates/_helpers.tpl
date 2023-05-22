{{/*
Expand the name of the chart.
*/}}
{{- define "firezone.name" -}}
{{- default .Chart.Name .Values.firezone.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "firezone.fullname" -}}
{{- if .Values.firezone.fullnameOverride }}
{{- .Values.firezone.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.firezone.nameOverride }}
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
{{- define "firezone.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "firezone.labels" -}}
helm.sh/chart: {{ include "firezone.chart" . }}
{{ include "firezone.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "firezone.selectorLabels" -}}
app.kubernetes.io/name: {{ include "firezone.name" . }}
app.kubernetes.io/instance: {{ include "firezone.name" . }}
app.kubernetes.io/component: {{ include "firezone.name" . }}
{{- end }}

{{/*
Create namespace
*/}}
{{- define "firezone.namespace" -}}
{{ default .Release.Namespace .Values.firezone.namespaceOverride }}
{{- end }}

{{/*
Service web
*/}}
{{- define "firezone.serviceweb.name" -}}
{{ default (printf "%s-%s" (include "firezone.name" .) "service") .Values.firezone.serviceweb.metadata.name }}
{{- end }}

{{/*
Service wireguard
*/}}
{{- define "firezone.servicewireguard.name" -}}
{{ default (printf "%s-%s" (include "firezone.name" .) "service") .Values.firezone.servicewireguard.metadata.name }}
{{- end }}




{{/*
Common labels
*/}}
{{- define "postgres.labels" -}}
{{ include "postgres.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "postgres.selectorLabels" -}}
app.kubernetes.io/name: postgres
app.kubernetes.io/instance: postgres
app.kubernetes.io/component: postgres
{{- end }}


{{/*
Service db
*/}}
{{- define "postgres.service.name" -}}
{{ default (printf "%s-%s" "postgres" "service") .Values.postgres.service.metadata.name }}
{{- end }}

