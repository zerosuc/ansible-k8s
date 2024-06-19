#!/bin/bash


function k8s::taint() {

  # 获取 master 节点的名称
  MASTER_NODE=$(kubectl get nodes -o wide | grep master | awk '{print $1}'| head -n 1)
  # 去掉 master 节点的污点
  kubectl taint nodes $MASTER_NODE node-role.kubernetes.io/master:NoSchedule-  >/dev/null 2>&1 || true

}

k8s::taint
