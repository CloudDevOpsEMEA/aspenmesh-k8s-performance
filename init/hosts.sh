#!/usr/bin/env bash

sudo tee -a /etc/hosts << END

# Host aliases for the UDF systems
10.1.1.4    jumphost
10.1.1.5    master
10.1.1.6    aspen1
10.1.1.7    aspen2
10.1.1.8    aspen3
10.1.1.9    aspen4
10.1.1.10   worker1
10.1.1.11   worker2
10.1.1.12   worker3
10.1.1.13   worker4
10.1.1.14   worker5

END

sudo tee -a /etc/hosts << END

# Host aliases for extra services
10.1.1.4    elasticsearch
10.1.1.4    kibana
END

sudo tee -a /etc/hosts << END

# Host aliases for istio gateway exposed workloads

END
