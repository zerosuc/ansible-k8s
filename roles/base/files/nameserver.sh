#!/usr/bin/env bash


function foo() {
    if ! grep -qF 'nameserver 8.8.8.8' /etc/resolv.conf; then
     echo 'nameserver 8.8.8.8' | sudo tee -a /etc/resolv.conf;
    fi
}

foo