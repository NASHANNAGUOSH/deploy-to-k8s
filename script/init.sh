#!/bin/bash

kind delete cluster --name demo

set -o errexit

# reg_name='kind-registry'
# reg_port='5000'
# k8s_version='1.18.8'

# Start a local Docker registry (unless it already exists)
# running="$(docker inspect -f '{{.State.Running}}' "${reg_name}" 2>/dev/null || true)"
# if [ "${running}" != 'true' ]; then
#   docker run \
#     -d --restart=always -p "${reg_port}:5000" --name "${reg_name}" \
#     registry:2
# fi
reg_name='kind-registry'
reg_port='5001'
if [ "$(docker inspect -f '{{.State.Running}}' "${reg_name}" 2>/dev/null || true)" != 'true' ]; then
  docker run \
    -d --restart=always -p "127.0.0.1:${reg_port}:5000" --name "${reg_name}" \
    registry:2
fi


# 创建集群
kind create cluster --name demo --config ./helm/cluster.yml

# connect the registry to the cluster network if not already connected
if [ "$(docker inspect -f='{{json .NetworkSettings.Networks.kind}}' "${reg_name}")" = 'null' ]; then
  docker network connect "kind" "${reg_name}"
fi

echo "👉开始部署local-registry......"
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: local-registry-hosting
  namespace: kube-public
data:
  localRegistryHosting.v1: |
    host: "localhost:${reg_port}"
    help: "https://kind.sigs.k8s.io/docs/user/local-registry/"
EOF
