
https://rak8s.io/

When I ran:

```
ansible-playbook cluster.yml
```

One of the messages I got was:

> ```
[DEPRECATION WARNING]: Invoking "apt" only once while using a loop via squash_actions is deprecated. Instead of using a
 loop to supply multiple items and specifying `name: "{{ item }}={{ kubernetes_package_version }}"`, please use `name:
['kubelet', 'kubeadm', 'kubectl']` and remove the loop. This feature will be removed in version 2.11. Deprecation
warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.
```

Another was:

> ```
[ERROR SystemVerification]: missing cgroups: memory
```

I removed `cgroup_memory=1` from `roles/common/files/cmdline.txt` and that :point_up: error stopped.

See https://github.com/rak8s/rak8s/pull/48 about reducing `gpu_mem`

Task `Join Kubernetes Cluster` failed for me because the workers couldn't resolve the master hostname. I added `/etc/hosts` entries so each node could resolve all the nodes by name.

Ran this manually on each worker:

```
sudo kubeadm join --token $TOKEN $MASTER:6443
sudo systemctl restart kubelet
```

`kubectl get nodes` says:

> The connection to the server localhost:8080 was refused - did you specify the right host or port?

`sudo kubectl get nodes` does the needful.
