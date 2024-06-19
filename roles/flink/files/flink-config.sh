#!/bin/bash

function flink::gen_flink_kube_config() {

# 设置命名空间和ServiceAccount的名称
NAMESPACE="flink"
SERVICE_ACCOUNT="flink-op"

kubectl create serviceaccount $SERVICE_ACCOUNT -n $NAMESPACE > /dev/null 2>&1 || true

kubectl create clusterrole flink-nodes --verb=list --resource=nodes
kubectl create clusterrolebinding flink-nodes-binding --clusterrole=flink-nodes --serviceaccount=$NAMESPACE:$SERVICE_ACCOUNT

# 创建一个Role，允许对flink命名空间下的所有资源进行多种操作
kubectl create role flink-namespace-wide --namespace=$NAMESPACE \
  --verb=create,get,list,watch,update,delete\
  --resource="*.*"

# 创建一个RoleBinding，将'flink' ServiceAccount与'flink-namespace-wide' Role绑定
kubectl create rolebinding flink-namespace-wide-binding --namespace=$NAMESPACE \
  --role=flink-namespace-wide --serviceaccount=$NAMESPACE:$SERVICE_ACCOUNT

# 获取ServiceAccount的Secret的名称
SECRET_NAME=$(kubectl get serviceaccount $SERVICE_ACCOUNT -n $NAMESPACE -o jsonpath="{.secrets[0].name}")

# 使用Secret的名称获取ServiceAccount的证书和上下文信息
USER_TOKEN=$(kubectl get secret $SECRET_NAME -n $NAMESPACE -o jsonpath="{.data.token}" | base64 --decode)
CLUSTER_NAME=$(kubectl config view --minify -o jsonpath='{.clusters[0].name}')
CLUSTER_SERVER=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')
CLUSTER_CA=$(kubectl get secret $SECRET_NAME -n $NAMESPACE -o jsonpath="{.data.ca\.crt}" | base64 --decode)

# 将证书写入一个文件
echo "$CLUSTER_CA" > /tmp/ca.crt

# 使用获取的信息创建新的kubeconfig文件
kubectl config set-cluster $CLUSTER_NAME \
  --kubeconfig=/tmp/flink-kubeconfig \
  --server=$CLUSTER_SERVER \
  --certificate-authority=/tmp/ca.crt \
  --embed-certs=true

kubectl config set-credentials $SERVICE_ACCOUNT \
  --kubeconfig=/tmp/flink-kubeconfig \
  --token=$USER_TOKEN

kubectl config set-context flink-context \
  --kubeconfig=/tmp/flink-kubeconfig \
  --cluster=$CLUSTER_NAME \
  --user=$SERVICE_ACCOUNT \
  --namespace=$NAMESPACE

kubectl config use-context flink-context --kubeconfig=/tmp/flink-kubeconfig

}

flink::gen_flink_kube_config