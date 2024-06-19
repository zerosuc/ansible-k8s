#!/usr/bin/env bash

function images() {
  for ns in $(kubectl get namespaces -o jsonpath={..metadata.name} );do
    echo -e  $ns;
    echo -e "\n"
    kubectl get pods -n $ns -o jsonpath="{.items[*].spec.containers[*].image}" |\
    tr -s '[[:space:]]' '\n' |\
    sort |\
    uniq -c
  done
}

images