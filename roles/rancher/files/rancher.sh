#!/usr/bin/env bash

function install_rancher() {

  if ! docker ps | grep -i "rancher/rancher"   > /dev/null ; then
      # Start Rancher server
      docker run --cpus=2 -m 4000M -d --privileged --restart=always -p 8080:80 -p 9443:443 \
          -v {{data_dir}}/rancher:/var/lib/rancher -v /host/certs:/container/certs \
          -e SSL_CERT_DIR="/container/certs" -e NO_PROXY="localhost,127.0.0.1,0.0.0.0,10.0.0.0/8" \
          rancher/rancher:v2.6.9
  else echo -e  "rancher installed\n"
  fi
}

install_rancher


