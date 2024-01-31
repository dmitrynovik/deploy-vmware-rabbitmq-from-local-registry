certmanagervsersion=1.13.0

kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v$certmanagervsersion/cert-manager.yaml

kubectl apply -f https://github.com/vmware-tanzu/carvel-kapp-controller/releases/latest/download/release.yml

kubectl apply -f https://github.com/vmware-tanzu/carvel-secretgen-controller/releases/latest/download/release.yml
