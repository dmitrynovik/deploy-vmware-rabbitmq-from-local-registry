ns="rabbitmq-system"
serviceaccount="rabbitmq"

kubectl create ns $ns

kubectl -n $ns create serviceaccount rabbitmq

echo "CREATING the CLUSTER rmq ROLE"
kubectl apply -f clusterrole.yml -n $ns --dry-run=client -o yaml | kubectl apply -f-

echo "CREATING the rmq CLUSTERROLEBINDING"
kubectl create clusterrolebinding rmq --clusterrole tanzu-rabbitmq-crd-install --serviceaccount $ns:$serviceaccount --dry-run=client -o yaml | kubectl apply -f-

echo "Deploying package-repository"
kapp deploy -n $ns -a tanzu-rabbitmq-repo -f package-repository-1.5.3-nocompression.yaml -y

echo "Deploying package-install"
kapp deploy -n $ns -a tanzu-rabbitmq -f packageinstall.yaml -y
