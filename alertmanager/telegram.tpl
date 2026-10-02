{{ define "telegram.message" }}
ALERTA [{{ .Status | toUpper }}] {{ .CommonLabels.alertname }}

{{- if .CommonLabels.severity }}Severity: {{ .CommonLabels.severity | toUpper }}{{ end }}
{{- if .CommonLabels.instance }}  
Instance: {{ .CommonLabels.instance }}{{ end }}
{{- if .CommonLabels.job }}
Job: {{ .CommonLabels.job }}{{ end }}

{{ if .CommonAnnotations.summary }}Summary: {{ .CommonAnnotations.summary }}{{ end }}
{{ if .CommonAnnotations.description }}Description: {{ .CommonAnnotations.description }}{{ end }}

{{ if gt (len .Alerts) 1 }}
{{ len .Alerts }} alerts grouped:
{{- range .Alerts }}
- {{ .Labels.instance }} - {{ .Annotations.summary }}
{{- end }}
{{ end }}

Time: {{ (index .Alerts 0).StartsAt | date "02 Jan 2006 15:04:05 MST" }}
{{ end }}

