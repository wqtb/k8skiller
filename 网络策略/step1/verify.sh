
#!/bin/bash
pod_info=$(kubectl get pods -o json | jq -r '.items[] | [.metadata.name, (.metadata.labels | to_entries[] | "\(.key)=\(.value)")]')
# 定义预期的 Pod 名称和标签
expected_pod_names=("approved-pod" "critical-pod" "test-pod")
expected_pod_labels=("access=approved" "type=critical" "type=test")

# 标志变量,用于跟踪验证结果
verified=0

# 遍历 $pod_info 数组
for pod_info in "${pod_info[@]}"; do
    # 将 pod_info 拆分为名称和标签
    IFS=',' read -ra pod_data <<< "$pod_info"
    pod_name="${pod_data[0]}"
    pod_labels="${pod_data[1]}"

    # 验证 Pod 名称是否符合预期
    if [[ "${expected_pod_names[*]}" == *"$pod_name"* ]]; then
        :
    else
        verified=1
    fi

    # 验证 Pod 标签是否符合预期
    if [[ "${expected_pod_labels[*]}" == *"$pod_labels"* ]]; then
        :
    else
        verified=1
    fi
done

# 根据验证结果返回退出状态
if [ $verified -eq 0 ]; then
    exit 0
else
    exit 1
fi

