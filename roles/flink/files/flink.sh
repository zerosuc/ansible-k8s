#!/usr/bin/env bash

function flink::install_pre() {
    # 创建flink命名空间
    kubectl create ns flink > /dev/null 2>&1 || true
    # 创建flink服务账户
    kubectl create serviceaccount flink -n flink > /dev/null 2>&1 || true
    # 创建flink集群角色绑定
    kubectl create clusterrolebinding flink-role-bind --clusterrole=edit --serviceaccount=flink:flink > /dev/null 2>&1 || true
}

flink::install_pre