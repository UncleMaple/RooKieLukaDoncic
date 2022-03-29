---
title: "Run Docker commands without sudo"
excerpt: ""
date: 2021-12-30 15:30:00 +0800
---


##### 1. Add the `docker` group if it doesn't already exist

```console
$ sudo groupadd docker
```

##### 2. Add the connected user `$USER` to the docker group

Optionally change the username to match your preferred user.

```console
$ sudo gpasswd -a $USER docker
```

**IMPORTANT**: Log out and log back in so that your group membership is re-evaluated.

##### 3. Restart the `docker` daemon

```console
$ sudo service docker restart
```

If you are on Ubuntu 14.04-15.10, use `docker.io` instead:

```console
$ sudo service docker.io restart
```

```console
sudo reboot
```
