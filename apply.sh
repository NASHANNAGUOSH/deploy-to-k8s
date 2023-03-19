#!/bin/bash

kubectl apply -f ./helm/nginx-deployment.yaml
kubectl apply -f ./helm/nginx-service.yaml
kubectl apply -f ./helm/nginx-ingress.yaml

# docker build -t my-react-app ./client
# docker tag my-react-app localhost:5001/my-react-app:latest
# docker push localhost:5001/my-react-app:latest

kubectl apply -f ./helm/deploy-web-client.yaml


