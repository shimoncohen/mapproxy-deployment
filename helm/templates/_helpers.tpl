{{- $releaseName := .Release.Name -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "mapproxy.name" -}}
{{- default .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mapproxy.fullname" -}}
{{- $name := default .Chart.Name }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mapproxy.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mapproxy.labels" -}}
helm.sh/chart: {{ include "mapproxy.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Returns the tag of the chart.
*/}}
{{- define "mapproxy.tag" -}}
{{- default (printf "v%s" .Chart.AppVersion) .Values.mapproxy.image.tag }}
{{- end }}

{{/*
Returns the environment from global if exists or from the chart's values, defaults to development
*/}}
{{- define "mapproxy.environment" -}}
{{- .Values.environment | default "development" -}}
{{- end -}}

{{/*
Returns the cloud provider name from global if exists or from the chart's values, defaults to minikube
*/}}
{{- define "mapproxy.cloudProviderFlavor" -}}
{{- .Values.cloudProvider.flavor | default "minikube" -}}
{{- end -}}

{{/*
Returns the cloud provider docker registry url from global if exists or from the chart's values
*/}}
{{- define "mapproxy.cloudProviderDockerRegistryUrl" -}}
{{- default .Values.global.cloudProvider.dockerRegistryUrl .Values.mapproxy.image.dockerRegistryUrl }}
{{- end -}}

{{/*
Returns the cloud provider image pull secret name from global if exists or from the chart's values
*/}}
{{- define "mapproxy.cloudProviderImagePullSecretName" -}}
{{- default .Values.global.cloudProvider.imagePullSecretName .Values.mapproxy.image.imagePullSecretName }}
{{- end -}}

{{/*
Returns the cloud provider docker registry url from global if exists or from the chart's values
*/}}
{{- define "mapproxy.nginx.cloudProviderDockerRegistryUrl" -}}
{{- default .Values.global.cloudProvider.dockerRegistryUrl .Values.nginx.image.dockerRegistryUrl }}
{{- end -}}

{{/*
Returns the cloud provider image pull secret name from global if exists or from the chart's values
*/}}
{{- define "mapproxy.nginx.cloudProviderImagePullSecretName" -}}
{{- default .Values.global.cloudProvider.imagePullSecretName .Values.nginx.image.imagePullSecretName }}
{{- end -}}

{{- define "map-proxy.cors.allowedHeaders" -}}
{{- $headerList := list -}}
{{- if ne .Values.mapproxy.env.cors.allowedHeaders "" -}}
{{- range $k, $v := (split "," .Values.mapproxy.env.cors.allowedHeaders) -}}
{{- $headerList = append $headerList $v -}}
{{- end -}}
{{- $headerList = uniq $headerList -}}
{{-  quote (join "," $headerList) -}}
{{- end -}}
{{- end -}}

{{/*
    Create a list of subPaths off the extraVolumeMounts in order to prevent conflict
    with user's subPaths list
*/}}
{{- define "listOfSubPaths" -}}
    {{- $subPathsList := list -}}
    {{- range .Values.nginx.extraVolumeMounts -}}
        {{- $subPathsList = append $subPathsList .subPath -}}
    {{- end -}}
    {{ toJson $subPathsList }}
{{- end -}}
