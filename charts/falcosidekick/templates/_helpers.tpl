{{- define "falcosidekick.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "falcosidekick.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}
