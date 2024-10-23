>网络策略Network Policy是kubernetes诸多资源的一种。由于在默认情况下kubernetes集群内的POD之间是互相通讯的，这不利于POD安全。因此有了Network Policy这种资源，缩写为netpol。需要注意的是netpol并非默认资源，需要安装CNI（容器网络接口），比如calico,cilium等。netpol在tcp/IP的第三层和第四层对pod的出入站流量进行控制。注意以下几点，一是netpol的作用域（pod级或namespace级）二是要灵活运用podselector或namespaceselector。三是分清楚入站还是出站，通过相应的标签来选择pod

请先创建`3`个`pod`,名称分别为`approved-pod`,`critical-pod`,`test-pod`,全部使用`nginx`镜像，这三个pod的标签分别为`access: approved`,`type: critical`,`type=text`.
Use a network policy to restrict ingress traffic for pods with labels "type: critical" only to allow traffic from pods with labels "access: approved".
