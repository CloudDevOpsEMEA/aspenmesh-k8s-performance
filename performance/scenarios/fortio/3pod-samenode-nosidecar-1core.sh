#!/usr/bin/env bash

FORTIO_CLIENT=$(kubectl get pods -n fortio -l app=fortio-client --output=jsonpath={.items..metadata.name})

TEST_DURATION=5m
QUERIES_PS=0

CONNECTION_ARRAY=( 16 256 1024 4096 8192 )
RESPONSE_SIZE_ARRAY=( 32 512 1024 2048 )

for res_s in "${RESPONSE_SIZE_ARRAY[@]}" ;do
  echo "========== RESPONSE_SIZE : ${res_s} =========="
  for con in "${CONNECTION_ARRAY[@]}" ; do
    LABELS="3pod-samenode-nosidecar-1core-conn${con}-resp${res_s}"
    FORTIO_CMD="/usr/bin/fortio load -jitter=true -c=${con} -qps=${QUERIES_PS} -t=${TEST_DURATION} -a -r=0.001 -labels=${LABELS} http://fortio-server:8080/echo\?size\=${res_s}"
    echo "kubectl -n fortio exec -it ${FORTIO_CLIENT} -c fortio -- ${FORTIO_CMD}"
    kubectl -n fortio exec -it ${FORTIO_CLIENT} -c fortio -- ${FORTIO_CMD} | grep "All done"
  done
done
