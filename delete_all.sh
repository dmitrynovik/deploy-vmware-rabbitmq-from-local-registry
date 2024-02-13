sudo kind delete cluster
sudo docker stop $(docker ps -q)
sudo docker rm $(docker ps -aq)

docker ps
