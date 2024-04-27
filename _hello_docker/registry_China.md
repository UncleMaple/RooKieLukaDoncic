---
title: "Docker镜像拉取配置"
excerpt: "解决docke国内镜像拉取慢的问题."
date: 2024-04-28 00:46:00 +0800
---

## Docker镜像拉取配置


```sh
# Create directory
sudo mkdir -p /etc/docker

# Write mirror configuration
sudo tee /etc/docker/daemon.json <<-'EOF'
{
    "registry-mirrors": [
        "https://docker.mirrors.ustc.edu.cn",
        "https://dockerproxy.com",
        "https://docker.nju.edu.cn"
    ]
}
EOF

# Restart Docker service
sudo systemctl daemon-reload
sudo systemctl restart docker
```