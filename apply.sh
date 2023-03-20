#!/bin/bash


kubectl create namespace gitlab
kubectl apply -f ./helm/gitlab/gitlab-redis.yaml
kubectl apply -f ./helm/gitlab/gitlab-postgresql.yaml
kubectl apply -f ./helm/gitlab/gitlab.yaml

kubectl apply -f ./helm/deploy-web-client.yaml


# docker build -t my-react-app ./client
# docker tag my-react-app localhost:5001/my-react-app:latest
# docker push localhost:5001/my-react-app:latest

kubectl apply -f ./helm/nginx.yaml
#kubectl apply -f ./helm/nginx-deployment.yaml
#kubectl apply -f ./helm/nginx-service.yaml
kubectl apply -f ./helm/nginx-ingress-web.yaml
kubectl apply -f ./helm/nginx-ingress-git.yaml
