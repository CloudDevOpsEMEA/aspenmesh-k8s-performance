# Makefile

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

CHART_DIR := ../../helm/fortio
SCENARIO  := scenario1
NAMESPACE := fortio

CONNECTIONS   := 64
REQUEST_SIZE  := 1024
RESPONSE_SIZE := 1024
RUN_DURATION  := 60s
QUERIES_PS    := 0

FORTIO_TEST := /usr/bin/fortio load \
	-jitter=true \
	-c=${CONNECTIONS} \
	-qps=${QUERIES_PS} \
	-t=${RUN_DURATION} \
	-payload-size=${REQUEST_SIZE} \
	-a \
	-r=0.001 \
	 http://fortio-server:8080/echo\?size\=${RESPONSE_SIZE}

install:  ## Install scenario
	kubectl create namespace ${NAMESPACE} || true
	helm install ${SCENARIO} ${CHART_DIR} --namespace ${NAMESPACE} --values ./${SCENARIO}.yaml || true

upgrade:  ## Upgrade scenario
	helm upgrade ${SCENARIO} ${CHART_DIR} --namespace ${NAMESPACE} --values ./${SCENARIO}.yaml || true

uninstall:  ## Uninstall scenario
	helm uninstall ${SCENARIO} --namespace ${NAMESPACE} || true
	kubectl delete namespace ${NAMESPACE} || true

reinstall: uninstall install  ## Reinstall scenario

restart:  ## Restart all microservices
	kubectl -n ${NAMESPACE} rollout restart deploy

view:  ## View all microservices
	kubectl -n ${NAMESPACE} get services -o wide
	kubectl -n ${NAMESPACE} get pods -o wide

run:  ## Run performance test
	kubectl -n fortio exec -it `kubectl get pods -n fortio -l app=fortio-client --output=jsonpath={.items..metadata.name}` -c fortio -- ${FORTIO_TEST}
