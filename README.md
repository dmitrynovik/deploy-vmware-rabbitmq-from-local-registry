
# Useful commands

## Get credentials
Assuming the cluster is `rabbit-1` and the namespace is `rabbitmq-system`:
```
ns="rabbitmq-system" # adjust this
cluster="rabbit-1"   # adjust this

sudo kubectl -n $ns get secret $cluster-default-user -o jsonpath="{.data.username}" | base64 --decode
sudo kubectl -n $ns get secret $cluster-default-user -o jsonpath="{.data.password}" | base64 --decode
```

## Enable all feature flags
```
sudo kubectl -n $ns exec -it $cluster-server-0 -- rabbitmqctl list_feature_flags

sudo kubectl -n $ns exec -it $cluster-server-0 -- rabbitmqctl enable_feature_flag all
sudo kubectl -n $ns exec -it $cluster-server-1 -- rabbitmqctl enable_feature_flag all
sudo kubectl -n $ns exec -it $cluster-server-2 -- rabbitmqctl enable_feature_flag all
```

