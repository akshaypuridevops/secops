{{- define "cortex.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "cortex.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}
