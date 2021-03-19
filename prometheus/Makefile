# Makefile

.PHONY: help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help


install-prometheus-grafana:  ## Install prometheus and grafana
	sudo apt-get install -y prometheus prometheus-node-exporter prometheus-pushgateway prometheus-alertmanager
	sudo snap install grafana
