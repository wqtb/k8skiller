#!/bin/sh

kubectl get job k8skiller

completions=$(kubectl get job k8skiller -o json | jq -r .spec.completions)
parallelism=$(kubectl get job k8skiller -o json | jq -r .spec.parallelism)

if [ "$completions" = "6" ] && [ "$parallelism" = "2" ]; then
    exit 0
else
    exit 1
fi
