{{- define "thehive.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "thehive.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}
