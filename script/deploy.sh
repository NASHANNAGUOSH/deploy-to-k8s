#!/bin/bash

dir=$(dirname "$0")
echo "脚本文件所在的目录：$dir"

# deploy gitlab
echo "👉部署gitlab......"
kubectl create namespace gitlab
kubectl apply -f $dir/../helm/gitlab/gitlab-redis.yaml
kubectl apply -f $dir/../helm/gitlab/gitlab-postgresql.yaml
kubectl apply -f $dir/../helm/gitlab/gitlab.yaml

# deploy client
echo "👉部署client......"
kubectl apply -f $dir/../helm/app/client.yaml


# docker build -t my-react-app ./client
# docker tag my-react-app localhost:5001/my-react-app:latest
# docker push localhost:5001/my-react-app:latest

#kubectl apply -f ./helm/nginx-deployment.yaml
#kubectl apply -f ./helm/nginx-service.yaml
