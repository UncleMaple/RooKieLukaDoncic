# Omnibus GitLab 的一点笔记

### 什么是Omnibus

    Omnibus GitLab, as previously described, 
    uses many of the Chef components like cookbooks, attributes, and resources. 
    GitLab EE uses a separate cookbook that extends from the one GitLab CE uses and adds the EE-only components.
    
**`cookbook`的方式用来集成我们gitcode的新UI？**

### Omnibus-gitlab 代码仓库地址

https://gitlab.com/gitlab-org/omnibus-gitlab.git

### 配置从哪拉取gitlab的代码 及其他组件

 代码仓 => `.custom_sources.yml`

在打omnibus包的时候可以指定前端包的文件夹位置 [参考文档地址](https://docs.gitlab.com/omnibus/build/build_package.html)

### 打包 all-in-one Docker image

#### 什么是all_in_one打包 ? 和普通omnibus-gitlab打包的区别？

* 都需要用docker来打包
* 普通打包会自动识别os来判断要打包的类型
* all-in-one 用了在ubuntu20.04环境下的包，适用于ci环境

文档的解释：`The GitLab all-in-one Docker image uses the omnibus-gitlab package built for Ubuntu 20.04 under the hood. The Dockerfile is optimized to be used in a CI environment, with the expectation of packages being available over the Internet.`

#### 查看仓库docker目录下的内容

#### 其他需要注意

```shell
# 打包
cd docker
docker build -t omnibus-gitlab-image:custom .
```

### 添加新的依赖

https://docs.gitlab.com/omnibus/development/new-software-definition.html

包含如何测试添加的依赖、重新打包

