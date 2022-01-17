---
title: "HELLO SSH"
excerpt: "ssh笔记"
---

## SSH To Server Without Password

local client public key to server keys, next login will not use password
```shell
cat ~/.ssh/id_rsa.pub | ssh root@192.168.3.105 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```
