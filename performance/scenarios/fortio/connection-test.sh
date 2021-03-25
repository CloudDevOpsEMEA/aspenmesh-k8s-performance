#!/usr/bin/env bash

TEST_DURATION=2m

CONNECTION_ARRAY=( 16 32 64 128 256 512 1024 2048 4096 8192 8704 9216 9728 10240 )
REQUEST_SIZE_ARRAY=( 4 128 512 1024 )
RESPONSE_SIZE_ARRAY=( 4 128 512 1024 )

for req_s in "${REQUEST_SIZE_ARRAY[@]}" ; do
  for res_s in "${REQUEST_SIZE_ARRAY[@]}" ;do
    for con in "${CONNECTION_ARRAY[@]}" ; do
      echo "REQ_SIZE : ${req_s} , RES_SIZE : ${res_s} , CONN : ${con}"
      make run RUN_DURATION=${TEST_DURATION} REQUEST_SIZE=${req_s} RESPONSE_SIZE=${res_s} CONNECTIONS=${con} | grep "All done"
    done
  done
done
