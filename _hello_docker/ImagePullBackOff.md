---
title: "解决docker拉取image错误： ImagePullBackOff"
excerpt: "解决修改proxy后无法拉取image, Error response from daemon: Get https://registry-1.docker.io/v2/: proxyconnect 
  tcp: dial tcp 127.0.0.1:1087: connect: connection refused."
# header:
#   # image: /assets/images/docker_header_bg.jpg
#   # teaser: /assets/images/foo-bar-identity-th.jpg
# sidebar:
#   - title: "Role"
#     image: http://placehold.it/350x250
#     image_alt: "logo"
#     text: "Designer, Front-End Developer"
#   - title: "Responsibilities"
#     text: "Reuters try PR stupid commenters should isn't a business model"
# gallery:
#   - url: /assets/images/unsplash-gallery-image-1.jpg
#     image_path: assets/images/unsplash-gallery-image-1-th.jpg
#     alt: "placeholder image 1"
#   - url: /assets/images/unsplash-gallery-image-2.jpg
#     image_path: assets/images/unsplash-gallery-image-2-th.jpg
#     alt: "placeholder image 2"
#   - url: /assets/images/unsplash-gallery-image-3.jpg
#     image_path: assets/images/unsplash-gallery-image-3-th.jpg
#     alt: "placeholder image 3"
---

## TroubleShooting

### `Init:ImagePullBackOff`

如果  `kubectl describe pod pod-instance-name` 中有如下输出:
```plaintext
  Warning  Failed     35m (x4 over 37m)      kubelet            Failed to pull image "gitlab/gitlab-runner:alpine-v13.12.0": rpc error: 
  code = Unknown desc = Error response from daemon: Get https://registry-1.docker.io/v2/: proxyconnect 
  tcp: dial tcp 127.0.0.1:1087: connect: connection refused
```

#### 解决方案：
##### 1. `sudo systemctl status docker` 
查看docker service 配置文件地址

<figure>
  <img src="{{ '/assets/images/docker-service-status.png' | relative_url }}" alt="docker-service-status">
</figure>

##### 2. `sudo vim /lib/systemd/system/docker.service`
在`[Service]`下添加: 
   
```shell
Environment="HTTPS_PROXY=http.docker.internal:3128"
Environment="HTTP_PROXY=http.docker.internal:3128"
```

![add-proxy-env]({{ "/assets/images/add-proxy-env.png" | relative_url }})

###### 3. `sudo systemctl daemon-reload`
   
###### 4. `sudo systemctl restart docker`
