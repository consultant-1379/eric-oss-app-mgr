{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "eric-oss-app-mgr.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "eric-oss-app-mgr.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create Ericsson product app.kubernetes.io info
*/}}
{{- define "eric-oss-app-mgr.kubernetes-io-info" -}}
app.kubernetes.io/name: {{ .Chart.Name | quote }}
app.kubernetes.io/version: {{ .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end -}}

{{/*
Create Ericsson Product Info
*/}}
{{- define "eric-oss-app-mgr.helm-annotations" -}}
ericsson.com/product-name: {{ (fromYaml (.Files.Get "eric-product-info.yaml")).productName | quote }}
ericsson.com/product-number: {{ (fromYaml (.Files.Get "eric-product-info.yaml")).productNumber | quote }}
ericsson.com/product-revision: {{ regexReplaceAll "(.*)[+|-].*" .Chart.Version "${1}" | quote }}
{{- end}}

{{/*
Create label information for the App Manager RED & USE Metric configmaps to enable CNOM Auto-Discovery
*/}}
{{- define "eric-oss-app-mgr.cnom-dashboards" -}}
{{- if index .Values "cnom-dashboards" "enabled" -}}
    ericsson.com/cnom-server-dashboard-models: "true"
{{- else -}}
    ericsson.com/cnom-server-dashboard-models: "false"
{{- end -}}
{{- end -}}

{{/*
Expand credential for eric-lcm-container-registry
*/}}
{{- define "eric-oss-app-mgr.lcmregistry" -}}
{{- if index .Values "eric-lcm-container-registry" "enabled" -}}
{{- $RegistrySecret := index .Values "eric-lcm-container-registry" -}}
  {{- if $RegistrySecret.registry.users.secret  -}}
    {{- print $RegistrySecret.registry.users.secret .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
  {{- else -}}
    {{- include "eric-oss-app-mgr.name" . -}}-lcmregistry
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Expand credential for eric-lcm-container-registry
*/}}
{{- define "eric-oss-app-mgr.lcmregistrycred" -}}
{{ if index .Values "eric-lcm-container-registry" "enabled" }}
{{- $RegistryUserPass := index .Values "eric-lcm-container-registry" -}}
{{ htpasswd $RegistryUserPass.registry.users.name $RegistryUserPass.registry.users.password  | b64enc | quote }}
{{- end -}}
{{- end -}}

{{/*
Create image pull secrets for keycloak client
*/}}
{{- define "eric-oss-app-mgr.pullSecrets" -}}
{{- if .Values.imageCredentials -}}
  {{- if .Values.imageCredentials.pullSecret -}}
    {{- print .Values.imageCredentials.pullSecret -}}
  {{- end -}}
  {{- else if .Values.global.pullSecret -}}
    {{- print .Values.global.pullSecret -}}
  {{- end -}}
{{- end -}}

{{/*
Create Service Mesh enabling option
*/}}
{{- define "eric-oss-app-mgr.service-mesh.enabled" -}}
{{ if .Values.global.serviceMesh }}
  {{ if .Values.global.serviceMesh.enabled }}
    {{- print "true" -}}
  {{ else }}
    {{- print "false" -}}
  {{- end -}}
{{ else }}
  {{- print "false" -}}
{{ end }}
{{- end}}

{{/*
Create Service Mesh Ingress enabling option
*/}}
{{- define "eric-oss-app-mgr.service-mesh-ingress.enabled" -}}
{{ if .Values.global.serviceMesh }}
  {{ if .Values.global.serviceMesh.ingress }}
    {{ if .Values.global.serviceMesh.ingress.enabled }}
  {{- print "true" -}}
    {{ else }}
  {{- print "false" -}}
    {{- end -}}
  {{ else }}
  {{- print "false" -}}
  {{- end -}}
{{ else }}
  {{- print "false" -}}
{{ end }}
{{- end}}

*/}}
{{- define "eric-oss-app-mgr.gateway-client-lcm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}-eric-oss-app-lcm
{{- end }}

*/}}
{{- define "eric-oss-app-mgr.gateway-client-onboarding.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}-eric-oss-app-onboarding
{{- end }}

*/}}
{{- define "eric-oss-app-mgr.gateway-client-lcm-v3.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}-eric-oss-app-lcm-v3
{{- end }}

*/}}
{{- define "eric-oss-app-mgr.gateway-client-onboarding-v2.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}-eric-oss-app-onboarding-v2
{{- end }}

*/}}
{{- define "eric-oss-app-mgr.gateway-client-helm-chart-registry.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}-eric-lcm-helm-chart-registry
{{- end }}

*/}}
{{- define "eric-oss-app-mgr.gateway-client-container-registry.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}-eric-lcm-container-registry
{{- end }}

{{/*
Create keycloak-client image registry url
*/}}
{{- define "eric-oss-app-mgr.keycloak-client.registryUrl" -}}
    {{- $registryUrl := .Values.global.registry.url -}}
    {{- $repoPath := .Values.keyCloak.imageCredentials.keycloakClient.repoPath -}}
    {{- $name := .Values.keyCloak.images.keycloakClient.name -}}
    {{- $tag := .Values.keyCloak.images.keycloakClient.tag -}}
    {{ if index .Values "keyCloak" "imageCredentials" "keycloakClient" "registry" "url" -}}
      {{- print $registryUrl "/" $repoPath "/" $name ":" $tag -}}
    {{- else -}}
      {{- print .Values.global.registry.url -}}
    {{- end -}}
{{- end -}}

*/}}
{{- define "eric-oss-app-mgr.rbac-config.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

*/}}
{{- define "eric-oss-app-mgr.roles-config.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

*/}}
{{- define "eric-oss-app-mgr.create-defaultUser.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

*/}}
{{- define "eric-oss-app-mgr.user-realm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

*/}}
{{- define "eric-oss-app-mgr.keycloak-app-mgr-user.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
The name of the cluster role used during openshift deployments.
This helper is provided to allow use of the new global.security.privilegedPolicyClusterRoleName if set, otherwise
use the previous naming convention of <release_name>-allowed-use-privileged-policy for backwards compatibility.
*/}}
{{- define "eric-oss-app-mgr.privileged.cluster.role.name" -}}
  {{- if hasKey (.Values.global.security) "privilegedPolicyClusterRoleName" -}}
    {{ .Values.global.security.privilegedPolicyClusterRoleName }}
  {{- else -}}
    {{ template "eric-oss-app-mgr.release.name" . }}-allowed-use-privileged-policy
  {{- end -}}
{{- end -}}

{{/*
Create release name used for cluster role.
*/}}
{{- define "eric-oss-app-mgr.release.name" -}}
{{- default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Check the global.security.tls enabling option.
*/}}
{{- define "eric-oss-app-mgr.global-security-tls-enabled" -}}
{{- if  .Values.global -}}
  {{- if  .Values.global.security -}}
    {{- if  .Values.global.security.tls -}}
      {{- .Values.global.security.tls.enabled | toString -}}
    {{- else -}}
      {{- "false" -}}
    {{- end -}}
  {{- else -}}
    {{- "false" -}}
  {{- end -}}
{{- else -}}
  {{- "false" -}}
{{- end -}}
{{- end -}}

{{/*
Check mTLS to IAM enabling option
*/}}
{{- define "eric-oss-app-mgr.global-security-mTls2Iam-enabled" }}
  {{- $mTls2IamEnabled := "false" -}}
  {{- if .Values.global -}}
    {{- if .Values.global.security -}}
      {{- if .Values.global.security.mTls2Iam -}}
        {{- $mTls2IamEnabled = .Values.global.security.mTls2Iam.enabled -}}
      {{- end -}}
    {{- end -}}
    {{- $mTls2IamEnabled -}}
  {{- end -}}
{{- end -}}

{{/*
Check IAM Client Credential Authentication enabling option
*/}}
{{- define "eric-oss-app-mgr.iam-client-credential-authn.enabled" -}}
{{- $serviceMesh := include "eric-oss-app-mgr.service-mesh.enabled" . | trim -}}
{{- $globalTls := include "eric-oss-app-mgr.global-security-tls-enabled" . | trim -}}
{{- $globalmTls2Iam := include "eric-oss-app-mgr.global-security-mTls2Iam-enabled" . | trim -}}
  {{- if and (eq $serviceMesh "true") (eq $globalTls "true") (eq $globalmTls2Iam "true")  -}}
    {{- "true" -}}
  {{- else -}}
    {{- "false" -}}
  {{- end -}}
{{- end -}}

{{/*
Check SIP-TLS Trusted root CA secret
*/}}
{{- define "eric-oss-app-mgr.sip-tls-trusted-internal-root-ca-secret" }}
{{- if (((((.Values.global).security).tls).trustedInternalRootCa).secret) }}
    {{- printf "%s" .Values.global.security.tls.trustedInternalRootCa.secret -}}
{{- else }}
    {{- printf "eric-sec-sip-tls-trusted-root-cert" -}}
{{- end }}
{{- end }}


{{/*
Check the ingress tls enabling option.
It will use tls.enabled when SM ingress is used, while use ingress.tls.enabled when ICCR ingress is used.
*/}}
{{- define "eric-oss-app-mgr.ingress-tls-enabled" -}}
{{- $serviceMeshIngress := include "eric-oss-app-mgr.service-mesh-ingress.enabled" . | trim -}}
{{- if eq $serviceMeshIngress "true" -}}
  {{- .Values.tls.enabled -}}
{{- else if .Values.ingress -}}
  {{- if .Values.ingress.enabled -}}
    {{- .Values.ingress.enabled -}}
  {{- else -}}
    {{- false -}}
  {{- end -}}
{{- else -}}
  {{- false -}}
{{- end -}}
{{- end -}}

{{/*
Create CertM Onboarding enabling option
*/}}
{{- define "eric-oss-app-mgr.certm-onboarding.enabled" }}
  {{- $useCertMOnboarding := "false" -}}
  {{- if .Values.global -}}
    {{- if .Values.global.useCertMOnboarding -}}
        {{- $useCertMOnboarding = .Values.global.useCertMOnboarding -}}
    {{- end -}}
  {{- end -}}
  {{- $useCertMOnboarding -}}
{{- end -}}

{{/*
This helper get the db user used to connect to postgres DB instance.
*/}}
{{- define "eric-oss-app-mgr.acm-runtime-db-username" -}}
  {{- $secretName := index .Values "eric-appmgr-data-document-db" "credentials" "kubernetesSecretName" -}}
  {{- if (lookup "v1" "Secret" .Release.Namespace $secretName) }}
      {{- $secret := (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
      {{ index $secret.data "super-user" }}
  {{- else }}
      {{/*
      This is just added to get past helm template command issues as it will not check the namespace for the required secret.
      */}}
      {{- print "foo" -}}
  {{- end -}}
{{- end -}}

{{/*
This helper get the db user password used to connect to postgres DB instance.
*/}}
{{- define "eric-oss-app-mgr.acm-runtime-db-password" -}}
  {{- $secretName := index .Values "eric-appmgr-data-document-db" "credentials" "kubernetesSecretName" -}}
  {{- if (lookup "v1" "Secret" .Release.Namespace $secretName) }}
      {{- $secret := (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
      {{ index $secret.data "super-pwd" }}
  {{- else }}
      {{/*
      This is just added to get past helm template command issues as it will not check the namespace for the required secret.
      */}}
      {{- print "bar" -}}
  {{- end -}}
{{- end -}}