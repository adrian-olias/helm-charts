{{- define "argocd-template.projectName" -}}
{{- required "name is required" .Values.name -}}
{{- end -}}

{{- define "argocd-template.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: {{ .Values.name }}
environment: {{ .Values.env }}
{{- end -}}
