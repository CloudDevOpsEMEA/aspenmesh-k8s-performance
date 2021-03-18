#!/usr/bin/env bash

sudo tee -a /etc/hosts << END

# Host aliases for the UDF systems
10.1.1.4    jumphost
10.1.1.5    master
10.1.1.6    node1
10.1.1.7    node2
10.1.1.8    node3
10.1.1.9    node4
10.1.1.10   node5
10.1.1.11   node6
10.1.1.12   node7
10.1.1.13   node8
10.1.1.14   node9

END

sudo tee -a /etc/hosts << END

# Host aliases for extra services
10.1.1.4    elasticsearch
10.1.1.4    kibana
END

sudo tee -a /etc/hosts << END

# Host aliases for istio gateway exposed workloads

END
