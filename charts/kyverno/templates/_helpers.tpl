{{- define "kyverno.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "kyverno.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}
