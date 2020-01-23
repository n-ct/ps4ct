#! /bin/bash

echo "Wiping Docker"
docker-compose down -v --rmi all && yes | docker system prune && yes | docker image prune -a && yes | docker volume prune 
