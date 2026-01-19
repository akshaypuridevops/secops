{{- define "kibana.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "kibana.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}
