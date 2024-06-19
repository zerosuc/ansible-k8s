#!/usr/bin/env bash

function real_ip() {
  kubectl patch configmap ingress-nginx-controller -n ingress-nginx --patch '{"data": {"compute-full-forwarded-for": "true", "forwarded-for-header": "X-Forwarded-For", "use-forwarded-headers": "true"}}'
}

real_ip
