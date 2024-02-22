ns_upstream="rabbitmq-system"
cluster_upstream="rabbitmq-1-upstream"

ns_downstream="rabbitmq-system"
cluster_downstream="rabbitmq-1-downstream"

echo -e "Upstream user:"
sudo kubectl -n $ns_upstream get secret "$cluster_upstream-default-user" -o jsonpath='{.data.username}' | base64 -d
echo -e "\nUpstream password:"
sudo kubectl -n $ns_upstream get secret "$cluster_upstream-default-user" -o jsonpath='{.data.password}' | base64 -d

echo -e "\n\nDownstream user:"
sudo kubectl -n $ns_downstream get secret "$cluster_downstream-default-user" -o jsonpath='{.data.username}' | base64 -d
echo -e "\nDownstream password:"
sudo kubectl -n $ns_downstream get secret "$cluster_downstream-default-user" -o jsonpath='{.data.password}' | base64 -d

echo -e "\n"