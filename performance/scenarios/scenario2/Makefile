# Makefile

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

GOSERVER_CHART_DIR := ../../helm/goserver
K6_CHART_DIR := ../../helm/k6
NAMESPACE := example

install:  ## Install microservices
	kubectl create namespace ${NAMESPACE} || true
	kubectl label namespace ${NAMESPACE} istio-injection=enabled --overwrite
	helm install service1 ${GOSERVER_CHART_DIR} --namespace ${NAMESPACE} --values ./service1.yaml || true
	helm install service2 ${GOSERVER_CHART_DIR} --namespace ${NAMESPACE} --values ./service2.yaml || true
	helm install service3 ${GOSERVER_CHART_DIR} --namespace ${NAMESPACE} --values ./service3.yaml || true
	helm install service4 ${GOSERVER_CHART_DIR} --namespace ${NAMESPACE} --values ./service4.yaml || true

upgrade:  ## Upgrade microservices
	helm upgrade service1 ${GOSERVER_CHART_DIR} --namespace ${NAMESPACE} --values ./service1.yaml || true
	helm upgrade service2 ${GOSERVER_CHART_DIR} --namespace ${NAMESPACE} --values ./service2.yaml || true
	helm upgrade service3 ${GOSERVER_CHART_DIR} --namespace ${NAMESPACE} --values ./service3.yaml || true
	helm upgrade service4 ${GOSERVER_CHART_DIR} --namespace ${NAMESPACE} --values ./service4.yaml || true

uninstall:  ## Uninstall microservices 
	helm uninstall service4 --namespace ${NAMESPACE} || true
	helm uninstall service3 --namespace ${NAMESPACE} || true
	helm uninstall service2 --namespace ${NAMESPACE} || true
	helm uninstall service1 --namespace ${NAMESPACE} || true
	kubectl delete namespace ${NAMESPACE} || true

reinstall: uninstall install  ## Reinstall microservices

view:  ## View all microservices
	kubectl -n ${NAMESPACE} get services -o wide
	kubectl -n ${NAMESPACE} get pods -o wide

k6_install:  ## Install and run k6 performance tool
	helm install k6 ${K6_CHART_DIR} --namespace ${NAMESPACE} --values ./k6.yaml || true

k6_upgrade:  ## Upgrade k6 performance tool
	helm upgrade k6 ${K6_CHART_DIR} --namespace ${NAMESPACE} --values ./k6.yaml || true

k6_uninstall:  ## Uninstall k6 performance tool
	helm uninstall k6 --namespace ${NAMESPACE} || true

k6_reinstall: k6_uninstall k6_install  ## Reinstall and run k6 performance tool

restart:  ## Restart all microservices
	kubectl -n ${NAMESPACE} rollout restart deploy
