---
title: "HELLO SHELL"
excerpt: "终端配置笔记(oh-my-zsh、plugin、theme)"
date: 2021-12-30 15:30:00 +0800
---

<!-- # Hello Shell -->

## 配置oh-my-zsh

### Install And Config ZSH Ad Your Default Shell
```sh
# 1. Install
sudo apt install zsh

# 2. check version
zsh --version

# 3. make it your default shell
chsh -s $(which zsh)

# 4. log out and log back again to your new default shell.

# 5. Test it worked(should result `/bin/zsh`)
echo $SHELL
```

### Install OhMyZsh

仓库地址 => [**https://github.com/ohmyzsh/ohmyzsh**](https://github.com/ohmyzsh/ohmyzsh)

```sh
# Use curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Use wget
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Config OhMyZsh

`vim ~/.zshrc`

```sh
# ~/.zshrc

# (Optional for easy use OR use powerlevel10k)
# change Theme (常用的主题有 cloud \ af-magic \ amuse)
# ZSH_THEME="af-magic" 

# add Plugins
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

bindkey ',' autosuggest-accept
[[ -s /root/.autojump/etc/profile.d/autojump.sh ]] && source /root/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u
```

#### Install zsh-syntax-highlighting
仓库地址 => [**https://github.com/zsh-users/zsh-syntax-highlighting**](https://github.com/zsh-users/zsh-syntax-highlighting)

```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

#### Install zsh-autosuggestions
仓库地址 => [**https://github.com/zsh-users/zsh-autosuggestions**](https://github.com/zsh-users/zsh-autosuggestions)

```sh
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
```

#### Install autojump
仓库地址 => [**https://github.com/wting/autojump**](https://github.com/wting/autojump)

```sh
# macos
brew install autojump

# Ubuntu,Debian
git clone git://github.com/wting/autojump.git
cd autojump

./install.py

cd .. && sudo rm -rf autojump
```

#### Enable config

```sh
source ~/.zshrc
```
### Config powerlevel10k Theme

仓库地址 => [**https://github.com/romkatv/powerlevel10k**](https://github.com/romkatv/powerlevel10k)

1. Clone the repository:
    ```zsh
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    ```
    Users in mainland China can use the official mirror on gitee.com for faster download.<br>
    中国大陆用户可以使用 gitee.com 上的官方镜像加速下载.

    ```zsh
    git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    ```
2. Set `ZSH_THEME="powerlevel10k/powerlevel10k"` in `~/.zshrc`.

## Dockerized playground

If you have Docker installed then you can use the below snippet to try this setup in a sandbox without installing anything or affecting your existing setup.

```sh
docker run -e LANG=C.UTF-8 -e LC_ALL=C.UTF-8 -e TERM=$TERM -it --rm ubuntu bash -uexc '
  apt update && apt install -y git curl zsh autojump && cd /root
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" --skip-chsh --unattended
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
  curl -fsSLO http://bit.ly/Spaceship10kTheme
  echo "source ~/Spaceship10kTheme" >~/.zshrc
  exec zsh'
```
