#!/usr/bin/env bash

#set -o errexit
set -o pipefail


function tmp::docker() {
  if [ ! -n "$1" ]  ;then
    echo  -e "input: install or uninstall\n"
  else
    if [ "$1" == "install" ]; then
        echo  -e "$1\n"
#        echo  -e "start install docker service \n"
        tmp::install_docker
    elif [ "$1" == "uninstall" ]; then
          echo  -e "$1\n"
#          echo  -e "start uninstall docker service \n"
          tmp::uninstall_docker
    else
       echo  -e "input error,pls input: install or uninstall"
    fi
  fi
}

## 前置条件:
# 需要将  docker-20.10.10.tgz 放在 /home目录就可以了
function tmp::install_docker() {
    result=`which docker`
    if [ $? -eq 0 ]; then
        echo -e "docker has installed! \n"
        return;
    else
        echo  -e "start install docker service \n"
    fi

    cd /home
    tar -zxvf docker-20.10.10.tgz -C /tmp
    cd /tmp/docker;
    chmod 777 *
    cp /tmp/docker/* /usr/bin/
    cd /etc/systemd/system/

    echo -e "touch service file \n"
    touch docker.service

cat >  /etc/systemd/system/docker.service  <<EOF
  [Unit]
  Description=Docker Application Container Engine
  Documentation=https://docs.docker.com
  After=network.target

  [Service]
  Type=notify
  # the default is not to use systemd for cgroups because the delegate issues still
  # exists and systemd currently does not support the cgroup feature set required
  # for containers run by docker
  ExecStart=/usr/bin/dockerd
  ExecReload=/bin/kill -s HUP $MAINPID
  # Having non-zero Limit*s causes performance problems due to accounting overhead
  # in the kernel. We recommend using cgroups to do container-local accounting.
  LimitNOFILE=infinity
  LimitNPROC=infinity
  LimitCORE=infinity
  # Uncomment TasksMax if your systemd version supports it.
  # Only systemd 226 and above support this version.
  #TasksMax=infinity
  TimeoutStartSec=0
  # set delegate yes so that systemd does not reset the cgroups of docker containers
  Delegate=yes
  # kill only the docker process, not all processes in the cgroup
  KillMode=process

  [Install]
  WantedBy=multi-user.target
EOF
  echo -e "start docker service \n"
  systemctl daemon-reload && systemctl start docker
  echo  -e "install docker done! check docker: \n"
  docker ps
}


function tmp::uninstall_docker() {
    result=`which docker `
    if [ $? -eq 0 ]; then
      echo  -e "start uninstall docker service \n"
    else
        echo -e "docker has not exists!\n"
        return
    fi

      cd /etc/systemd/system/
      rm -rf docker.service
      cd  /usr/bin/

      rm -rf  containerd  \
              containerd-shim \
              containerd-shim-runc-v2 \
              ctr \
              docker \
              docker-init \
              docker-proxy \
              dockerd \
              runc
       echo -e  "uninstall_docker done!\n"

}


tmp::docker $1


#docker run -it --rm --name ansible  -v /home/zxw/share/ansible:/ansible 10.30.26.151:80/devopstools/ansible-playbook:v2.9.1 /bin/bash

