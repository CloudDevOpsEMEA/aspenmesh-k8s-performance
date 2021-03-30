# Makefile

ASPEN_NAMESPACE=istio-system
ASPEN_VERSION=1.6.14-am4
ASPEN_VALUES=./udf-values-${ASPEN_VERSION}.yaml
ASPEN_DIR=./aspenmesh-carrier-grade-${ASPEN_VERSION}
CHART_DIR=${ASPEN_DIR}/manifests/charts
CERT_DIR=../certificates/cluster

ISTIO_VERSION=1.6.14

ANALYSIS_EMULATOR_NAMESPACE=analysis-emulator
ANALYSIS_EMULATOR_CHART_DIR=${ASPEN_DIR}/samples/aspenmesh/analysis-emulator

KIALI_VALUES=./post-install/kiali/udf-values-kiali.yaml


HELM_ARGS=
# HELM_ARGS=--debug

.PHONY: help install upgrade uninstall istioctl post-install post-uninstall

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

install: istioctl  ## Install aspenmesh
	kubectl create ns ${ASPEN_NAMESPACE} || true
	kubectl create secret generic cacerts -n ${ASPEN_NAMESPACE} \
		--from-file=${CERT_DIR}/ca-cert.pem \
		--from-file=${CERT_DIR}/ca-key.pem \
		--from-file=${CERT_DIR}/root-cert.pem \
		--from-file=${CERT_DIR}/cert-chain.pem 
	helm install istio-base ${CHART_DIR}/base --namespace ${ASPEN_NAMESPACE} ${HELM_ARGS} || true
	echo "sleeping 10 sec" && sleep 10
	helm install istio-discovery ${CHART_DIR}/istio-control/istio-discovery --namespace ${ASPEN_NAMESPACE} --values ${ASPEN_VALUES} ${HELM_ARGS} || true
	echo "sleeping 120 sec" && sleep 120
	# helm install istio-ingress ${CHART_DIR}/gateways/istio-ingress --namespace ${ASPEN_NAMESPACE} --values ${ASPEN_VALUES} ${HELM_ARGS} || true
	# helm install istio-egress ${CHART_DIR}/gateways/istio-egress --namespace ${ASPEN_NAMESPACE} --values ${ASPEN_VALUES} ${HELM_ARGS} || true
	helm install istio-telemetry ${CHART_DIR}/istio-telemetry/grafana --namespace ${ASPEN_NAMESPACE} --values ${ASPEN_VALUES} ${HELM_ARGS} || true
	kubectl apply -f ./post-install/

upgrade:  ## Upgrade aspenmesh
	helm upgrade istio-base ${CHART_DIR}/base --namespace ${ASPEN_NAMESPACE} ${HELM_ARGS} || true
	echo "sleeping 10 sec" && sleep 10
	helm upgrade istio-discovery ${CHART_DIR}/istio-control/istio-discovery --namespace ${ASPEN_NAMESPACE} --values ${ASPEN_VALUES} ${HELM_ARGS} || true
	echo "sleeping 20 sec" && sleep 20
	# helm upgrade istio-ingress ${CHART_DIR}/gateways/istio-ingress --namespace ${ASPEN_NAMESPACE} --values ${ASPEN_VALUES} ${HELM_ARGS} || true
	# helm upgrade istio-egress ${CHART_DIR}/gateways/istio-egress --namespace ${ASPEN_NAMESPACE} --values ${ASPEN_VALUES} ${HELM_ARGS} || true
	helm upgrade istio-telemetry ${CHART_DIR}/istio-telemetry/grafana --namespace ${ASPEN_NAMESPACE} --values ${ASPEN_VALUES} ${HELM_ARGS} || true
	kubectl apply -f ./post-install/

uninstall:  ## Uninstall aspenmesh
	kubectl delete -f ./post-install || true
	helm uninstall istio-telemetry --namespace ${ASPEN_NAMESPACE} || true
	# helm uninstall istio-egress --namespace ${ASPEN_NAMESPACE} || true
	# helm uninstall istio-ingress --namespace ${ASPEN_NAMESPACE} || true
	helm uninstall istio-discovery --namespace ${ASPEN_NAMESPACE} || true
	helm uninstall istio-base --namespace ${ASPEN_NAMESPACE} || true
	kubectl delete ns ${ASPEN_NAMESPACE} || true

reinstall:  uninstall install ## Ininstall and install aspenmesh

istioctl:  ## Install istioctl
	curl -sL https://istio.io/downloadIstioctl | ISTIO_VERSION=${ISTIO_VERSION} sh - && \
	sudo cp ~/.istioctl/bin/istioctl /usr/local/bin

kiali-install:  ## Install kiali
	helm install --namespace istio-system --values ${KIALI_VALUES} --repo https://kiali.org/helm-charts kiali-server kiali-server
	kubectl apply -f ./post-install/kiali/04-kiali-nodeport-svc.yaml

kiali-upgrade:  ## Upgrade kiali
	helm upgrade --namespace istio-system --values ${KIALI_VALUES} --repo https://kiali.org/helm-charts kiali-server kiali-server
	kubectl apply -f ./post-install/kiali/04-kiali-nodeport-svc.yaml

kiali-uninstall:  ## Uninstall kiali
	helm uninstall --namespace istio-system kiali-server
	kubectl delete crd monitoringdashboards.monitoring.kiali.io
	kubectl delete -f ./post-install/kiali/04-kiali-nodeport-svc.yaml

node-exporter-install:  ## Install node-exporter
	helm repo add bitnami https://charts.bitnami.com/bitnami || true
	helm install --namespace kube-system node-exporter bitnami/node-exporter

node-exporter-upgrade:  ## Upgrade node-exporter
	helm upgrade --namespace kube-system node-exporter bitnami/node-exporter

node-exporter-uninstall:  ## Uninstall node-exporter
	helm uninstall --namespace kube-system node-exporter

analysis-emulator-install:  ## Install aspen mesh packet capture analysis emulator
	kubectl create ns ${ANALYSIS_EMULATOR_NAMESPACE}
	kubectl label --overwrite ns ${ANALYSIS_EMULATOR_NAMESPACE} ca.istio.io/override=true
	helm install analysis-emulator --namespace ${ANALYSIS_EMULATOR_NAMESPACE} ${ANALYSIS_EMULATOR_CHART_DIR}
	kubectl label --overwrite ns ${ASPEN_NAMESPACE} ca.istio.io/override=true

analysis-emulator-upgrade:  ## Upgrade aspen mesh packet capture analysis emulator
	helm upgrade analysis-emulator --namespace ${ANALYSIS_EMULATOR_NAMESPACE} ${ANALYSIS_EMULATOR_CHART_DIR}
	kubectl label --overwrite ns ${ASPEN_NAMESPACE} ca.istio.io/override=true

analysis-emulator-uninstall:  ## Uninstall aspen mesh packet capture analysis emulator
	helm uninstall analysis-emulator --namespace ${ANALYSIS_EMULATOR_NAMESPACE} || true
	kubectl delete ns analysis-emulator
	kubectl label --overwrite ns ${ASPEN_NAMESPACE} ca.istio.io/override=false

bookinfo-install:  ## Install the bookinfo demo application
	kubectl create ns bookinfo
	kubectl label namespace bookinfo istio-injection=enabled
	kubectl apply -n bookinfo -f ${ASPEN_DIR}/samples/bookinfo/platform/kube/bookinfo.yaml
	kubectl apply -n bookinfo -f ${ASPEN_DIR}/samples/bookinfo/networking/bookinfo-gateway.yaml
	kubectl apply -n bookinfo -f ${ASPEN_DIR}/samples/bookinfo/networking/destination-rule-all-mtls.yaml

bookinfo-uninstall:  ## Uninstall the bookinfo demo application
	kubectl delete -n bookinfo -f ${ASPEN_DIR}/samples/bookinfo/networking/destination-rule-all-mtls.yaml
	kubectl delete -n bookinfo -f ${ASPEN_DIR}/samples/bookinfo/networking/bookinfo-gateway.yaml || true
	kubectl delete -n bookinfo -f ${ASPEN_DIR}/samples/bookinfo/platform/kube/bookinfo.yaml || true
	kubectl delete ns bookinfo

update-grafana:  ## Update to grafana 7.5.0
	kubectl patch deployment grafana --type merge --patch `cat ./post-install/grafana/deployment-patch.yaml`
