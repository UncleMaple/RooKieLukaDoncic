---
title: "HELLO SSH"
excerpt: "ssh笔记"
date: 2021-12-30 15:30:00 +0800
---

## SSH To Server Without Password

local client public key to server keys, next login will not use password
```shell
cat ~/.ssh/id_rsa.pub | ssh root@192.168.3.105 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```

### Add Alias To Client

```shell
vim ~/.ssh/config
```

(
    Set alias to ubuntu_server
    user to root
    port to 22
)

Add lines:


```shell
Host ubuntu_server
     HostName 192.168.1.112
     User root
     Port 22
```

Then next you can access ssh server:

```shell
ssh ubuntu_server
```
