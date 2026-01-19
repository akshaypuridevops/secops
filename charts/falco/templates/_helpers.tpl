{{- define "falco.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "falco.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}
