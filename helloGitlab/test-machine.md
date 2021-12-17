# TEST MACHINE T1

## Basic Info
ip => `192.168.72.76`

user => `gitcoder`

password => `gitcode.net`


## Config
Add this lines to `~/.ssh/config`

```shell
Host gitcode-t1
HostName 192.168.72.76
User gitcoder
```

### SSH without password (Optional)

Execute this command in your host terminal:
```shell
cat ~/.ssh/id_rsa.pub | ssh gitcoder@192.168.72.76  "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```

## How to use

`ssh gitcode-t1`

Well Done.