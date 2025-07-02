{{/*
Create wmts/wms service name as used by the service type.
*/}}
{{- define "service.fullname" -}}
{{- printf "%s-%s-%s" .Release.Name .Chart.Name "service" | indent 1 }}
{{- end }}

{{/*
Create mapproxy configmap name as used by the service name label.
*/}}
{{- define "configmap.fullname" -}}
{{- printf "%s-%s-%s" .Release.Name .Chart.Name "configmap" | indent 1 }}
{{- end }}

{{/*
Create ingress name as used by the service name label.
*/}}
{{- define "nginx.fullname" -}}
{{- printf "%s-%s-%s" .Release.Name .Chart.Name "nginx" | indent 1 }}
{{- end }}

{{/*
Create mapproxy nginx configmap name as used by the service name label.
*/}}
{{- define "nginx-configmap.fullname" -}}
{{- printf "%s-%s-%s" .Release.Name .Chart.Name "nginx-configmap" | indent 1 }}
{{- end }}

{{/*
Create mapproxinator container configmap name as used by the service name label.
*/}}
{{- define "mapproxinator-configmap.fullname" -}}
{{- printf "%s-%s-%s" .Release.Name .Chart.Name "mapproxinator-configmap" | indent 1 }}
{{- end }}

{{/*
Create deployment name as used by the service name label.
*/}}
{{- define "deployment.fullname" -}}
{{- printf "%s-%s-%s" .Release.Name .Chart.Name "deployment" | indent 1 }}
{{- end }}

{{/*
Create route name as used by the service name label.
*/}}
{{- define "route.fullname" -}}
{{- printf "%s-%s-%s" .Release.Name .Chart.Name "route" | indent 1 }}
{{- end }}

{{/*
Create ingress name as used by the service name label.
*/}}
{{- define "ingress.fullname" -}}
{{- printf "%s-%s-%s" .Release.Name .Chart.Name "ingress" | indent 1 }}
{{- end }}
