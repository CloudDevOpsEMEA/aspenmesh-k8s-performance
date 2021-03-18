# Makefile

GIT_REPO=https://github.com/CloudDevOpsEMEA/aspenmesh-k8s-performance
HOME_DIR=/home/ubuntu
REPO_DIR=${HOME_DIR}/aspenmesh-k8s-performance


.PHONY: help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help


install-k8s: ## Install k8s using kubespray
	cd /tmp && git clone https://github.com/kubernetes-sigs/kubespray.git && \
	cd kubespray && git checkout release-2.15 && \
	cp -R ${REPO_DIR}/kubespray/aspenmesh /tmp/kubespray/inventory && \
	sudo pip3 install -r requirements.txt && \
	ansible-playbook -i inventory/aspenmesh/hosts.yaml  --become --become-user=root cluster.yml


reboot-k8s: ## Reboot k8s cluster hosts
	ssh master sudo reboot || true
	ssh aspen1 sudo reboot || true
	ssh aspen2 sudo reboot || true
	ssh aspen3 sudo reboot || true
	ssh aspen4 sudo reboot || true
	ssh worker1 sudo reboot || true
	ssh worker2 sudo reboot || true
	ssh worker3 sudo reboot || true
	ssh worker4 sudo reboot || true
	ssh worker5 sudo reboot || true


git-clone-all: ## Clone all git repos
	ssh jumphost 		'cd ${HOME_DIR} ; git clone ${GIT_REPO}' || true
	ssh master  		'cd ${HOME_DIR} ; git clone ${GIT_REPO}' || true
	ssh aspen1   		'cd ${HOME_DIR} ; git clone ${GIT_REPO}' || true
	ssh aspen2   		'cd ${HOME_DIR} ; git clone ${GIT_REPO}' || true
	ssh aspen3   		'cd ${HOME_DIR} ; git clone ${GIT_REPO}' || true
	ssh aspen4   		'cd ${HOME_DIR} ; git clone ${GIT_REPO}' || true
	ssh worker1   	'cd ${HOME_DIR} ; git clone ${GIT_REPO}' || true
	ssh worker2   	'cd ${HOME_DIR} ; git clone ${GIT_REPO}' || true
	ssh worker3   	'cd ${HOME_DIR} ; git clone ${GIT_REPO}' || true
	ssh worker4   	'cd ${HOME_DIR} ; git clone ${GIT_REPO}' || true
	ssh worker5   	'cd ${HOME_DIR} ; git clone ${GIT_REPO}' || true


git-pull-all: ## Pull all git repos
	ssh jumphost 		'cd ${REPO_DIR}; git pull ; sudo updatedb' || true
	ssh master  		'cd ${REPO_DIR}; git pull ; sudo updatedb' || true
	ssh aspen1   		'cd ${REPO_DIR}; git pull ; sudo updatedb' || true
	ssh aspen2   		'cd ${REPO_DIR}; git pull ; sudo updatedb' || true
	ssh aspen3   		'cd ${REPO_DIR}; git pull ; sudo updatedb' || true
	ssh aspen4   		'cd ${REPO_DIR}; git pull ; sudo updatedb' || true
	ssh worker1  		'cd ${REPO_DIR}; git pull ; sudo updatedb' || true
	ssh worker2  		'cd ${REPO_DIR}; git pull ; sudo updatedb' || true
	ssh worker3  		'cd ${REPO_DIR}; git pull ; sudo updatedb' || true
	ssh worker4   		'cd ${REPO_DIR}; git pull ; sudo updatedb' || true
	ssh worker5   		'cd ${REPO_DIR}; git pull ; sudo updatedb' || true
