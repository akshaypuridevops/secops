{{- define "elasticsearch.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "elasticsearch.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}
