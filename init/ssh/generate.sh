#!/usr/bin/env bash

TMP_BASE_DIR=/tmp/ssh-udf

echo "Creating temporary output folders"
mkdir -p ${TMP_BASE_DIR}/jumphost
mkdir -p ${TMP_BASE_DIR}/master
mkdir -p ${TMP_BASE_DIR}/aspen1
mkdir -p ${TMP_BASE_DIR}/aspen2
mkdir -p ${TMP_BASE_DIR}/aspen3
mkdir -p ${TMP_BASE_DIR}/aspen4
mkdir -p ${TMP_BASE_DIR}/worker1
mkdir -p ${TMP_BASE_DIR}/worker2
mkdir -p ${TMP_BASE_DIR}/worker3
mkdir -p ${TMP_BASE_DIR}/worker4
mkdir -p ${TMP_BASE_DIR}/worker5

echo "Generating ssh key pairs"
ssh-keygen -b 2048 -t rsa -f ${TMP_BASE_DIR}/jumphost/id_rsa -C ubuntu@jumphost -q -N ""
ssh-keygen -b 2048 -t rsa -f ${TMP_BASE_DIR}/master/id_rsa   -C ubuntu@master   -q -N ""
ssh-keygen -b 2048 -t rsa -f ${TMP_BASE_DIR}/aspen1/id_rsa   -C ubuntu@aspen1   -q -N ""
ssh-keygen -b 2048 -t rsa -f ${TMP_BASE_DIR}/aspen2/id_rsa   -C ubuntu@aspen2   -q -N ""
ssh-keygen -b 2048 -t rsa -f ${TMP_BASE_DIR}/aspen3/id_rsa   -C ubuntu@aspen3   -q -N ""
ssh-keygen -b 2048 -t rsa -f ${TMP_BASE_DIR}/aspen4/id_rsa   -C ubuntu@aspen4   -q -N ""
ssh-keygen -b 2048 -t rsa -f ${TMP_BASE_DIR}/worker1/id_rsa  -C ubuntu@worker1  -q -N ""
ssh-keygen -b 2048 -t rsa -f ${TMP_BASE_DIR}/worker2/id_rsa  -C ubuntu@worker2  -q -N ""
ssh-keygen -b 2048 -t rsa -f ${TMP_BASE_DIR}/worker3/id_rsa  -C ubuntu@worker3  -q -N ""
ssh-keygen -b 2048 -t rsa -f ${TMP_BASE_DIR}/worker4/id_rsa  -C ubuntu@worker4  -q -N ""
ssh-keygen -b 2048 -t rsa -f ${TMP_BASE_DIR}/worker5/id_rsa  -C ubuntu@worker5  -q -N ""

echo "Moving ssh keypairs to repo"
mv ${TMP_BASE_DIR}/* .
