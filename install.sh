 
#!/bin/bash

set -e

namespace="rabbitmq-system"
rabbitmq_package_version="1.3.2"
serviceaccount=rabbitmq
app="tanzu-rabbitmq"

echo "Creating namespace: $namespace"
kubectl create ns rabbitmq-system --dry-run=client -o yaml | kubectl apply -f-
 
echo "Deploying package repository"
kapp deploy -n $namespace -a $app-repo -f package-repository.yaml -y

echo "Getting all packages"
kubectl -n $namespace get packages

echo "Create serviceaccount $serviceaccount if does not exist..."
kubectl create serviceaccount $serviceaccount -n $namespace --dry-run=client -o yaml | kubectl apply -f-

echo "Create clusterrole"
kubectl apply -f clusterrole.yml -n $namespace

echo "Create the rmq clusterrolebinding if does not exist..."
kubectl create clusterrolebinding rmq --clusterrole tanzu-rabbitmq-crd-install \
    --serviceaccount $namespace:$serviceaccount \
    --dry-run=client -o yaml \
    | kubectl apply -f-


echo "Deploying PackageInstall":
export RMQ_rabbitmq__version="$rabbitmq_package_version"
export RMQ_rabbitmq__serviceaccount="$serviceaccount"

# DEBUG:
#ytt -f packageInstall.yaml --data-values-env RMQ 
#kapp deploy -n $namespace -a tanzu-rabbitmq -f packageinstall.yaml -y
ytt -f packageInstall.yaml --data-values-env RMQ | kapp deploy --debug -a $app -y -n $namespace -f-


