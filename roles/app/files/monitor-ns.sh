#!/usr/bin/env bash


function del_if_exist() {
    if kubectl get ns cattle-dashboards >/dev/null 2>&1; then
        kubectl delete ns cattle-dashboards
    fi

    # Set the release name and namespace
    RELEASE_NAME="rancher-monitoring"
    NAMESPACE="cattle-monitoring-system"
    if helm list -n $NAMESPACE | grep -q $RELEASE_NAME; then
      helm uninstall $RELEASE_NAME -n $NAMESPACE
    fi
}
del_if_exist