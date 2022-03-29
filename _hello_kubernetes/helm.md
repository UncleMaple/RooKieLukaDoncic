---
title: "HELLO HELM"
excerpt: "Helm 笔记"
date: 2021-12-30 15:30:00 +0800
---

<!-- # HELLO HELM -->

## 三大概念

- `chart` 代表 Helm 包
- `repository`（仓库）存放 chart 的地方, 类似apt
- `release` 运行在 kubernetes集群 中的 chart实例 

## 什么是Helm

    Helm 安装 charts 到 Kubernetes 集群中，每次安装都会创建一个新的 release。你可以在 Helm 的 chart repositories 中寻找新的 chart。


## 常用命令

### 搜索chart

`helm search hub wordpress`

`helm search [repo] [some-chart-name]`

### 安装chart

`helm install happy-panda[自定义命名的release名字] bitnami/wordpress[要安装的chart名称]`

`helm status happy-panda` 追踪release的状态

#### 安装前自定义chart

chart有默认配置选项， 多数时候我们需要自定义chart指定配置

`helm show values [chart-name]` 查看chart中的可配置选项

[指定配置 的文档地址](https://helm.sh/zh/docs/intro/using_helm/#%E5%AE%89%E8%A3%85%E5%89%8D%E8%87%AA%E5%AE%9A%E4%B9%89-chart)
```shell
$ echo '{gitlabUrl: http://test-code.csdn.net/, runnerRegistrationToken: GeSh6-pBBz4_6oAfCMB
f}' > values.yaml

$ helm install -f values.yaml gitlab/gitlab-runner --generate-name

# 查看生效的配置
$ helm get values gitlab-runner-1624258634[release-name]
```

### 升级chart新版本 或 修改release配置

```shell
helm upgrade -f panda.yaml happy-panda bitnami/wordpress
```

### 回滚

```shell
$ helm rollback happy-panda 1
```

上面这条命令将我们的 happy-panda 回滚到了它最初的版本。release 版本其实是一个增量修订（revision）。 每当发生了一次安装、升级或回滚操作，revision 的值就会加1。第一次 revision 的值永远是1。我们可以使用 helm history [RELEASE] 命令来查看一个特定 release 的修订版本号。

### 卸载release

```shell
$ helm uninstall happy-panda[release-name]
```

### helm repo 仓库相关

`helm repo list` 查看配置的仓库

`helm repo add dev https://example.com/dev-charts` 添加仓库

`helm repo update [repo-name]` 更新仓库客户端

`helm repo remove [repo-name]` 移除仓库



