# Provable Security For Certificate Transparency #
The PS4CT repository contains configuration files and references to the certificate-transparency-go and trillian library. This allows ps4ct to be

## Configure Development Environment ##
These instructions are tested on Ubuntu 18.02. They should work fine with Mac/Linux but will probably need modifications for Windows. On Windows, using the WSL shell is recommended.

1. Install Go 1.12
```
On Windows: Read https://github.com/golang/go/wiki/Windows
On Mac/Linux: curl -LO https://get.golang.org/$(uname)/go_installer && chmod +x go_installer && ./go_installer -version 1.12 && rm go_installer
```
2. Save Environment Variables
```
echo "export GO111MODULE=on" >> ~/.bash_profile && source ~/.bash_profile
```
3. Clone PS4CT:
```
Via SSH: git clone --recursive git@github.com:zorawar87/ps4ct.git
Via HTTPS: git clone --recursive https://github.com/zorawar87/ps4ct.git
```
4. Update the sub-modules (ct-go and trillian)
```
cd ./ps4ct && git submodule update --remote
```
4. Switch to the ct-go repository and resolve dependencies
```
cd ./certificate-transparency-go && go mod download
```
5. Verify tests
```
go test ./...
```

## Running/Deployment Instructions ##
`Docker` allows software to be within a container by following steps from a `Dockerfile`. The advantage is that when running a system, docker automatically installs dependencies and configured a system.

`Docker-Compose` allows managing multiple Docker containers as defined in `docker-compose.yml`.

### Set up Docker and Docker-Compose ###
1. Install Docker and Docker-Compose.
  - Using [snap](Snapcraft.io) package: `sudo snap install docker`
  - Direct Installation
    - Get [Docker](https://docs.docker.com/get-docker/)
    - Complete [post-install instructions](https://docs.docker.com/engine/install/linux-postinstall/).
    - Install [Docker Compose](https://docs.docker.com/compose/install/).

### Configure PS4CT containers ###
1. Switch the to PS4CT repository `cd /path/to/ps4ct`
2. `docker-compose build` (this will take a bit for the first time)
3. To run a:
   - Logger: `docker-compose up ctserver` (mentioning ctserver and/or other writes its logs to stdout)
   - Bash Shell into CTServer Container: `docker-compose run ctserver bash`
   - MySQL Shell connected to the CTServer (and other services): `docker-compose run ctserver mysql`

### Docker Tips and Troubleshooting ###
* by adding `alias d=docker` and `alias dc=docker-compose`, the commands can be invoked by `d` and `dc` resp.
* Docker may need to be run as root if the post-install configuration was not completed. run with `sudo docker ...` or `sudo docker-compose ...`
* Sometimes docker complains about a compose_timeout. try `dc up ...` again or increase the timeout `export COMPOSE_HTTP_TIMEOUT=120` and try again.
* Delete Local Docker images and volumes `dc down -v --rmi local`
* Clear docker system and volume cache  `yes | d system prune && yes | d volume prune`
