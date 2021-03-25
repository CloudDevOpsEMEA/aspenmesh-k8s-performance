#!/usr/bin/env bash

FORTIO_CLIENT=$(kubectl get pods -n fortio -l app=fortio-client --output=jsonpath={.items..metadata.name})

TEST_DURATION=1m
QUERIES_PS=0

CONNECTION_ARRAY=( 16 64 512 1024 4096 8192 )
RESPONSE_SIZE_ARRAY=( 4 128 512 1024 )

for res_s in "${REQUEST_SIZE_ARRAY[@]}" ;do
  for con in "${CONNECTION_ARRAY[@]}" ; do

    echo "RES_SIZE : ${res_s} , CONN : ${con}"
    FORTIO_CMD="/usr/bin/fortio load \
      -jitter=true \
      -c=${con} \
      -qps=${QUERIES_PS} \
      -t=${TEST_DURATION} \
      -a \
      -r=0.001 \
      http://fortio-server:8080/echo\?size\=${res_s}"
    kubectl -n fortio exec -it ${FORTIO_CLIENT} -c fortio -- ${FORTIO_CMD} | grep "All done"

  done
done
