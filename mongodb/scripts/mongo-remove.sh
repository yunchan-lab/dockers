#!/bin/bash

# data 삭제
rm -rf data

# docker mongo container 삭제
echo "docker-compose down"
docker-compose down

# mongo network 삭제
if [ ! -z "$(docker network ls | grep mongoCluster)" ]; then
    docker network rm mongoCluster
    echo "Docker network 'mongoCluster' deleted."
else
    echo "Docker network 'mongoCluster' does not exist."
fi

# mongo image 삭제
if [ ! -z "$(docker images -q mongo)" ]; then
    docker rmi $(docker images -q mongo)
    echo "Mongo image(s) removed."
else
    echo "No Mongo image to remove."
fi

# /etc/hosts DNS host 삭제
hosts_entries=(
"127.0.0.1 mongo1"
"127.0.0.1 mongo2"
"127.0.0.1 mongo3"
)

for entry in "${hosts_entries[@]}"; do
    sudo sed -i '' -e "/$entry/d" /etc/hosts
    echo "Removed from /etc/hosts: $entry"
done