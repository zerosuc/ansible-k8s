#!/usr/bin/env bash

port=8422
server_ip="10.200.82.35" # file server

function upload_files() {
    for module in harbor rancher n9e k8s base app flink categraf
    do
         rsync -avz --update  -e "ssh -p $port" ./roles/$module/files root@$server_ip:/opt/data/sdb/packages/k8s/ansible/all/$module/
    done
    ## ansible self
    rsync -avz --update -e "ssh -p $port" ./install-ansible-aarch64.tar.gz  root@$server_ip:/opt/data/sdb/packages/k8s/ansible/all/
    rsync -avz --update -e "ssh -p $port" ./install-ansible-x86_64.tar.gz  root@$server_ip:/opt/data/sdb/packages/k8s/ansible/all/
    rsync -avz --update -e "ssh -p $port" ./ansible.deb  root@$server_ip:/opt/data/sdb/packages/k8s/ansible/all/roles
    rsync -avz --update -e "ssh -p $port" ./sshpass.zip  root@$server_ip:/opt/data/sdb/packages/k8s/ansible/all/roles
}

function download_all_files() {
  for module in harbor k8s base app flink
  do
    rsync -avz --update -e "ssh -p $port"  root@$server_ip:/opt/data/sdb/packages/k8s/ansible/all/$module/files    ./roles/$module/
  done
    rsync -avz --update -e "ssh -p $port" root@$server_ip:/opt/data/sdb/packages/k8s/ansible/all/*.tar.gz  .
    rsync -avz --update -e "ssh -p $port" root@$server_ip:/opt/data/sdb/packages/k8s/ansible/all/*.deb  .
    rsync -avz --update -e "ssh -p $port" root@$server_ip:/opt/data/sdb/packages/k8s/ansible/all/*.zip  .
    rsync -avz --update -e "ssh -p $port" root@$server_ip:/opt/data/sdb/packages/k8s/ansible/all/*.rpm  .
    rsync -avz --update  -e "ssh -p $port" root@$server_ip:/opt/data/sdb/packages/k8s/ansible/all/other  .
}

#upload_files
download_all_files
