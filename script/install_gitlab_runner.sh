#!/bin/bash

# GitLab 实例的 URL 和 Runner 注册令牌
GITLAB_URL="http://192.168.71.103:8888/"
# 注册令牌（可以在项目的 Settings > CI/CD > Runners 或 GitLab 管理员区域的 Admin Area > Overview > Runners 中找到）。
# Runner 的描述，例如 "My Mac Runner"。
REGISTRATION_TOKEN="gbWeRo_hE5yNh_oEyS_4"


# 通过 Homebrew 安装 GitLab Runner
echo "Installing GitLab Runner..."
# sudo curl --output /usr/local/bin/gitlab-runner "https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-darwin-arm64"

sudo chmod +x /usr/local/bin/gitlab-runner

# 注册 GitLab Runner
echo "Registering GitLab Runner..."
gitlab-runner register \
    --non-interactive \
    --url "$GITLAB_URL" \
    --registration-token "$REGISTRATION_TOKEN" \
    --executor "shell" \
    --description "My Mac Runner" \
    --tag-list "shell"

# 启动 GitLab Runner
echo "Starting GitLab Runner..."
gitlab-runner start


