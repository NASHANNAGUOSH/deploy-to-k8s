#!/bin/bash
dir=$(dirname "$0")
echo "脚本文件所在的目录：$dir"
# deploy apps ingress
kubectl apply -f $dir/../helm/ingress/ingress-client.yaml
kubectl apply -f $dir/../helm/ingress/ingress-gitlab.yaml
