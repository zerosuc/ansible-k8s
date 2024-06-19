#!/usr/bin/env bash


#cat >>  /etc/sysctl.conf <<EOF
#net.ipv4.ip_forward=1
#net.ipv4.tcp_max_syn_backlog=262144
#net.ipv4.tcp_max_tw_buckets=10000
#net.ipv4.tcp_tw_recycle=1
#net.ipv4.tcp_tw_reuse=1
#net.ipv4.tcp_fin_timeout=30
#net.ipv4.tcp_syncookies=1
#net.ipv4.tcp_keepalive_probes=5
#net.ipv4.tcp_syn_retries=2
#net.core.somaxconn=1024
#EOF
#
#sysctl -p
#
#cat >>  /etc/security/limits.conf   <<EOF
#* soft nofile 65536
#* hard nofile 65536
#* soft nproc 131072
#* hard nproc 131072
#EOF

##shell prom

function setps() {
    if ! grep -qF '033' /root/.bash_profile; then
     echo 'export PS1="[\[\033[01;31m\]\u\[\033[00m\]@\[\033[01;32m\]\H\[\033[00m\] \[\033[01;33m\]\w\[\033[00m\]]\[\033[01;34m\]$\[\033[00m\]"' | sudo tee -a  /root/.bash_profile;
    fi

    if [ -L /opt/app ]; then
      echo -e 'link exists!\n'
    else
        mkdir /data/app  -p
        cd /opt
        ln -s /data/app  app
        echo -e "create link done!"
    fi
}

setps


