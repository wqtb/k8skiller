>任务和定时任务分别是kubernetes中的资源，Job和cronJob，它们与pod或deployment不同。Job用来执行具体单个任务，而cj用来定时执行某项任务，因此job要有相应的执行模板，执行次数，并行次数。而CJ需要设置相应的schedule(用中文写这些真的不方便，建议还是看英文的)

请你创建一个任务，这个任务的名字为`k8skiller`,使用`nginx`镜像，要求执行`6`次，同时`两个`任务并行
