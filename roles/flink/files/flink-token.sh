#!/usr/bin/env bash

function flink::get_token() {
    kubectl get secret -n flink $(kubectl get serviceaccount flink -n flink -o jsonpath='{.secrets[0].name}') -o jsonpath='{.data.token}' | base64 --decode > /tmp/flink-token
}

flink::get_token