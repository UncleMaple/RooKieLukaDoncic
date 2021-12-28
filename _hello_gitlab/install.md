---
title: "Gitlab Install Troubleshooting"
excerpt: "Gitlab 安装过程中遇到的问题及解决方案."
---

<!-- # Install Troubleshooting -->

## Install libgit2 from source

![git2 error](assets/git2_error.png)

[git2go v30](https://github.com/libgit2/git2go#which-go-version-to-use) 对应 libgit2 [1.0.1](https://github.com/libgit2/libgit2/releases/tag/v1.0.1) 版本


[libgit2 repo](https://github.com/libgit2/libgit2)

```shell
wget https://github.com/libgit2/libgit2/archive/refs/tags/v1.3.0.tar.gz -O libgit2-1.3.0.tar.gz
tar xzf libgit2-1.3.0.tar.gz
cd libgit2-1.3.0/
cmake .
make
sudo make install
```
