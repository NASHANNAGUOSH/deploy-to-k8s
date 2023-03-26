#!/bin/bash

# helm install my-chart ./my-chart --set spec.hostAliases[0].ip=1.2.3.4,spec.hostAliases[0].hostnames[0]=example.hostname.com


helm install gitlab-runner gitlab/gitlab-runner -n gitlab -f ./gitlab-runner.value.yaml \
  --set hostAliases[0].ip=192.168.71.103  \
  --set hostAliases[0].hostnames[0]=git.nashannaguo.com
