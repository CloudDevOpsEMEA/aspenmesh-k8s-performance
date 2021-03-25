# Makefile

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

CHART_DIR := ../../helm/goserver
NAMESPACE := example

install:  ## Install microservices
	kubectl create namespace ${NAMESPACE} || true
	kubectl label namespace ${NAMESPACE} istio-injection=enabled --overwrite
	helm install service1 ${CHART_DIR} --namespace ${NAMESPACE} --values ./service1.yaml || true

upgrade:  ## Upgrade microservices
	helm upgrade service1 ${CHART_DIR} --namespace ${NAMESPACE} --values ./service1.yaml || true

uninstall:  ## Uninstall microservices 
	helm uninstall service1 --namespace ${NAMESPACE} || true
	kubectl delete namespace ${NAMESPACE} || true

reinstall: uninstall install  ## Reinstall microservices

restart:  ## Restart all microservices
	kubectl -n ${NAMESPACE} rollout restart deploy

view:  ## View all microservices
	kubectl -n ${NAMESPACE} get services -o wide
	kubectl -n ${NAMESPACE} get pods -o wide

k6_install:  ## Install and run k6 performance tool
	kubectl  -n ${NAMESPACE} apply -f ./k6.yaml

k6_uninstall:  ## Uninstall and run k6 performance tool
	kubectl  -n ${NAMESPACE} delete -f ./k6.yaml

k6_reinstall: k6_uninstall k6_install  ## Reinstall and run k6 performance tool
