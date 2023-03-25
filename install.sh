#!/bin/bash

function install_kind_cluster() {
    echo "👉开始安装kind集群......"
    sh ./script/init.sh
}

function deploy_nginx_ingress() {
  # deploy nginx ingress
  echo "👉部署nginx controller......."
  kubectl apply -f ./helm/nginx.yaml
  echo "👉等待nginx ingress安装完成.....(如果等待很久，请检查网络问题)"
  # 循环检查状态
  while true
  do
    # 检查Pod状态
    status=$(kubectl get pod -l app.kubernetes.io/component=controller  -n ingress-nginx -o jsonpath='{.items[*].status.phase}')
    # 如果Pod状态为 "Running"，则退出循环
    if [[ "$status" == "Running" ]]; then
       echo "👉nginx ingress安装成功"
       echo "👉开始部署应用....."
      sh ./script/deploy.sh
      break
    fi
    # 等待1秒后再次检查状态
    sleep 1
  done
}

 function install_client_ingress() {
   echo "👉等待准备安装client ingress.....)"
     # 循环检查状态
     while true
     do
       # 检查Pod状态
       status=$(kubectl get pod -l app=react-app  -n default -o jsonpath='{.items[*].status.phase}')
       # 如果Pod状态为 "Running"，则退出循环
       if [[ "$status" == "Running" ]]; then
          echo "👉react-app安装成功"
          echo "👉开始安装ingress....."
          kubectl apply -f ./helm/ingress/ingress-client.yaml
         break
       fi
       # 等待1秒后再次检查状态
       sleep 1
     done
 }

 function install_gitlab_ingress() {
     echo "👉等待应用安装完成才能部署ingress.....)"
     # 循环检查状态
     while true
     do
       # 检查Pod状态
       status=$(kubectl get pod -l name=gitlab  -n gitlab -o jsonpath='{.items[*].status.phase}')
       # 如果Pod状态为 "Running"，则退出循环
       if [[ "$status" == "Running" ]]; then
          echo "👉react-app安装成功"
          echo "👉开始安装ingress....."
          kubectl apply -f ./helm/ingress/ingress-gitlab.yaml
         break
       fi
       # 等待1秒后再次检查状态
       sleep 1
     done
 }

 install_kind_cluster
 deploy_nginx_ingress
 install_client_ingress
 install_gitlab_ingress

#kubectl get pod -l app.kubernetes.io/component=controller  -n ingress-nginx -o jsonpath='{.status.phase}'
