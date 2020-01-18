Instuctions on getting Certspotter (monitor) up and running.
Additional documentation/more information is at https://github.com/SSLMate/certspotter

Download the docker file from folder that this documentation is in.

Go to the folder where you downloaded the documentation from. 

docker build -t moniternamehere .   

docker run -itd --network=ps4ct_default moniternamehere 

to verify if it is a part of the network run the command.

docker network inspect ps4ct_default
(if you are unfamiliar with all the containers there should now be 5 of them, it will have an interesting name). 

Type:
docker container ls
(take note of the container id, which would be a string of alpha numerics.)

Run the following command to enter that container:
docker exec -it container-idhere bash


You will need to go into the ~/root/ directory. 
 'mkdir .certspotter'
 'cd .certspotter'      (this will be a hidden folder because of the .)
 'touch watchlist'
 'apt update && apt install vim'
 'vim watchlist'
 
 
 Add in the dns for the domains you wish to watch, wild cards are accepted. (see example below)
 Although not documented ( it is in cmd/certspotter/main.go line: 89-90), you can also just put a '.' in the watchlist, and it will return all the certificates that it acquires. 
 
*.google.com


Go to the go/src/…/certspotter/cmd/certspotter directory and 'go run main.go'
The official repo has arguments that can be used.
