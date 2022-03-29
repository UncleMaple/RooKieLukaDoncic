---
title: "HELLO KcpTun"
excerpt: "ubuntu 配置kcp服务(包括服务端和客户端)开机自启"
date: 2021-12-30 15:30:00 +0800
---

ubuntu 配置kcp服务

wget https://github.com/xtaci/kcptun/releases/download/v20170525/kcptun-linux-amd64-20170525.tar.gz
tar xvf kcptun-linux-amd64-20170525.tar.gz
sudo mv server_linux_amd64 /usr/local/bin/kcptun_server
sudo mv client_linux_amd64 /usr/local/bin/kcptun_client
sudo mkdir -p /etc/kcptun

sudo bash -c "cat <<EOT > /etc/kcptun/server_conf.json
{
    \"listen\": \":29001\",
    \"target\": \"[ip]:[port]\",
    \"mode\": \"fast3\",
    \"dscp\": 46,
    \"crypt\": \"aes\",
    \"key\": \"password\",
    \"datashard\": 10,
    \"parityshard\": 3,
    \"mtu\": 1350,
    \"sndwnd\": 1024,
    \"rcvwnd\": 1024,
}
EOT"

sudo bash -c "cat <<EOT > /etc/systemd/system/kcptun_server.service
[Unit]
Description=Kcptun server
Requires=network.target
After=network-online.target
    
[Service]
Type=simple
User=nobody
RemainAfterExit=yes
ExecStart=/usr/local/bin/kcptun_server -c /etc/kcptun/server_conf.json
ExecReload=/usr/bin/kill -HUP $MAINPID
RestartSec=1min
Restart=on-failure
    
[Install]
WantedBy=multi-user.target
EOT"

sudo systemctl enable kcptun_server
sudo systemctl start kcptun_server


sudo bash -c "cat <<EOT > /etc/kcptun/client_conf.json
{
    \"localaddr\": \":29001\",
    \"remoteaddr\": \"[remote_server_ip]:[remote_kcp_port]\",
    \"mode\": \"fast3\",
    \"dscp\": 46,
    \"crypt\": \"aes\",
    \"key\": \"password\",
    \"datashard\": 10,
    \"parityshard\": 3,
    \"mtu\": 1350,
    \"sndwnd\": 1024,
    \"rcvwnd\": 1024
}
EOT"

sudo bash -c "cat <<EOT > /etc/systemd/system/kcptun_client.service
[Unit]
Description=Kcptun client
Requires=network.target
After=network-online.target
    
[Service]
Type=simple
User=nobody
RemainAfterExit=yes
ExecStart=/usr/local/bin/kcptun_client -c /etc/kcptun/client_conf.json
ExecReload=/usr/bin/kill -HUP $MAINPID
RestartSec=1min
Restart=on-failure
    
[Install]
WantedBy=multi-user.target
EOT"

sudo systemctl enable kcptun_client
sudo systemctl start kcptun_client
