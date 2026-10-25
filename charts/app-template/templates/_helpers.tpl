{{- /* Name of the app: nameOverride, else fullnameOverride, else the chart name. */ -}}
{{- define "app-template.name" -}}
{{- default .Chart.Name (default .Values.fullnameOverride .Values.nameOverride) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "app-template.fullname" -}}
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

{{- define "app-template.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "app-template.imageTag" -}}
{{- default .Chart.AppVersion .Values.image.tag }}
{{- end }}

{{- define "app-template.selectorLabels" -}}
app.kubernetes.io/name: {{ include "app-template.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "app-template.labels" -}}
helm.sh/chart: {{ include "app-template.chart" . }}
{{ include "app-template.selectorLabels" . }}
app.kubernetes.io/version: {{ include "app-template.imageTag" . | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.commonLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{- define "app-template.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "app-template.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
