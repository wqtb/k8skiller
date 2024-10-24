#!/bin/bash

# 获取所有 Pod 的名称和标签
pod_info=$(kubectl get pods -o json | jq -r '.items[] | [.metadata.name, (.metadata.labels | to_entries[] | "\(.key)=\(.value)")]')

# 定义预期的 Pod 名称和标签
expected_pod_names=("approved-pod" "critical-pod" "test-pod")
expected_pod_labels=("access=approved" "type=critical" "type=test")

# 遍历每个 Pod 的信息
while IFS=',' read -ra pod_data; do
    pod_name="${pod_data[0]}"
    pod_labels="${pod_data[1]}"

    # 验证 Pod 名称是否符合预期
    if [[ " ${expected_pod_names[*]} " == *" $pod_name "* ]]; then
        exit 0
    else
        exit 1
    fi

    # 验证 Pod 标签是否符合预期
    if [[ " ${expected_pod_labels[*]} " == *" $pod_labels "* ]]; then
        exit 0
    else
        exit 1
    fi
done <<< "$pod_info"

