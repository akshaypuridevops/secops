{{- define "logstash.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "logstash.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}
