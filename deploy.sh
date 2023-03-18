#!/bin/bash

# 创建集群
kind create cluster --name demo --config ./helm/cluster.yml
kubectl create namespace gitlab
kubectl create -f ./helm/gitlab/gitlab-redis.yaml 
kubectl create -f ./helm/gitlab/gitlab-postgresql.yaml 
kubectl create -f ./helm/gitlab/gitlab.yaml


