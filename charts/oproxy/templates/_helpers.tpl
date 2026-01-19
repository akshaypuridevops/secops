{{- define "oproxy.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "oproxy.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}
