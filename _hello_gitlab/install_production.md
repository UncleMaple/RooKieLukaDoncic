---
title: "部署Gitlab到生产环境"
excerpt: "Gitlab文档docker启动，源码部署，备份机器，还原机器的解决方案."
toc: true
---

<!-- # 部署Gitlab到生产环境 -->

## 准备 `Gitlab13-7` 文档

**docker启动文档**

```sh
docker run -it --rm -p 4000:4000 registry.gitlab.com/gitlab-org/gitlab-docs:13.7
```


**根据文档安装** 

[**http://127.0.0.1:4000/13.7/ee/install/installation.html**](http://127.0.0.1:4000/13.7/ee/install/installation.html)

## 备份Ubuntu系统(Gitlab环境)

```sh
cd /home/git && mkdir tmp

sudo tar -cvpzf backup.tar.gz --exclude=/proc --exclude=/tmp --exclude=/boot  --exclude=/lost+found --exclude=/media --exclude=/mnt --exclude=/run --exclude=/sys --exclude=/dev --exclude=home/git/tmp / > /dev/null
```

**Attention** 

不加 `> /dev/null` 时，执行tar指令，遇到如下错误，最有可能是因为你想打包压缩的文件夹中，存在用户不够的读取权限。

`tar: Exiting with failure status due to previous errors`

加上 `> /dev/null` ， 在执行指令时，会发现只输出错误讯息。很多时引起的错误原因都是权限问题，只要针对权限有问题的文件，修改权限或移除文件，重新再尝试执行指令。

## 拷贝 备份`backup.tar.gz` 到 U盘

**1.** 装了gitlab的机器上 插入U盘

**2.** `sudo fdisk -l` 查找U盘的位置，比如找到 `/dev/sdc1`

**3.** `sudo mkdir -p /media/my_udisk && sudo mount /dev/sdc1 /media/my_udisk`

**4.** `sudo cp /[some_path]/backup.tar.gz /media/my_udisk/`

**More Info**

压缩了的文件夹有:

```txt
bin      home     lib64    root     srv      var
cdrom    lib      libx32   sbin     swapfile
etc      lib32    opt      snap     usr
```

解压缩到指定文件夹:

```sh
tar -zxvf backup.tar.gz -C /Users/maple/work/csdn_work/tmp/backup
```

## 还原备份的Ubuntu系统

### 重装干净的Ubuntu系统

使用U盘（ubuntu安装盘）给目标磁盘重装一个干净的系统

### 还原备份

**1.** 插入有`backup.tar.gz`备份的U盘

**2.** 再次使用U盘（ubuntu安装盘）进入系统，这次选择`try ubuntu`

**3.** 进入 **磁盘** 应用，选择 **挂载(mount)** 新装Ubuntu主机的硬盘

**4.** 进入终端

```sh
sudo su

# 在tryUbuntu根目录下有media文件夹，里面是U盘文件夹和新安装的系统文件夹，在在里分别用（U盘）和（UBUNTU）表示
cd /media/（U盘）
mount -o remount rw ./
 ​
# （可选）将新系统根目录下/boot/grub/grub.cfg文件备份到U盘中
# sudo cp /media/(Ubuntu)/boot/grub/grub.cfg ./    
 ​
# 将新系统根目录下/etc/fstab文件备份到U盘中，fstab是与系统开机挂载有关的文件，grub.cfg是与开机引导有关的文件，所以这一步至关重要
sudo cp /media/(UBUNTU)/etc/fstab ./
 ​
# (可选)这一步删除新装ubuntu全部的系统文件，有用的fstab及grub.cfg已经备份
# cd /media/(UBUNTU)
# sudo rm -rf ./*
 ​
# 将U盘中backup.tgz复制到该目录下并解压缩
cp /media/(U盘)/backup.tar.gz ./
sudo tar -zxvf backup.tar.gz -C ./
 ​
# (可选)创建打包系统时排除的文件
# sudo mkdir proc lost+found mnt sys media

# 还原fstab
sudo cp /media/(U盘)/etc/fstab /media/(UBUNTU)/etc/fstab
```

## 修改域名

```sh
# 更改各个配置文件域名部分

vim /home/git/gitlab-shell/config.yml

vim /home/git/gitlab/config/gitlab.yml

vim /home/git/gitaly/config.toml

sudo service gitlab restart
```

## 健康检查

```sh
bundle exec rake gitlab:check RAILS_ENV=production
```