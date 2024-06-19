#!/usr/bin/env bash

function ssh_no_passwd() {

    if [ ! -d ~/.ssh ]; then
        mkdir ~/.ssh
    fi

    if [ ! -f ~/.ssh/id_rsa ]; then
        ssh-keygen -t rsa -f ~/.ssh/id_rsa -P ""
    fi

}

ssh_no_passwd