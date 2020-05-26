# Provable Security For Certificate Transparency #
The PS4CT repository contains configuration files and references to the certificate-transparency-go and trillian library. This allows ps4ct to be

## Configure Development Environment ##
These instructions are tested on Ubuntu 18.02. They should work fine with Mac/Linux but will probably need modifications for Windows. On Windows, using the WSL shell is recommended.

1. Install Go 1.11
```
On Windows: Read https://github.com/golang/go/wiki/Windows
On Mac/Linux: curl -LO https://get.golang.org/$(uname)/go_installer && chmod +x go_installer && ./go_installer -version 1.11 && rm go_installer
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

### When deploying to production ###
_These instructions only apply, when docker-compose is set up on a server machine._
* To deploy a logger:
  1. SSH into a remote machine
  2. Start the ctserver service in the background `dc up ctserver`
  3. Once the logs prove that the system is running ok, background the process by hitting `ctrl+z`
  4. Detach the process from the current shell `disown -h`
  5. Log off from the SSH session and try to connect to the ct instance on the remote machine. Make sure that the remote machine allows inbound requests on relevant ports.

### Docker Tips and Troubleshooting ###
* by adding `alias d=docker` and `alias dc=docker-compose`, the commands can be invoked by `d` and `dc` resp.
* Docker may need to be run as root if the post-install configuration was not completed. run with `sudo docker ...` or `sudo docker-compose ...`
* Sometimes docker complains about a compose_timeout. try `dc up ...` again or increase the timeout `export COMPOSE_HTTP_TIMEOUT=120` and try again.
* Delete Local Docker images and volumes `dc down -v --rmi local`
* Clear docker system and volume cache  `yes | d system prune && yes | d volume prune`
* Clear all docker images and containers not in use `yes | d system prune -a`
* Upgrade computer (and restart): `sudo apt update && sudo apt upgrade`
* Make sure docker is being run as root: `sudo groupadd docker && sudo usermod -a -G docker <username>`

## Adding a new, real Source Log ##
To the appropriate config file (such as `gossec.cfg`), copy the format for a source log. Use information from the [Official list of Known Logs](https://www.gstatic.com/ct/log_list/v2/log_list.json).
1. Modify the Name, URL, and MMD (min_req_interval)
2. Copy the ECDSA Public Key (in Base64 format)
3. Convert it to hex using a service like [this one](https://base64.guru/converter/decode/hex). Set the delimiter to '\x'
4. Paste the key in the config under `public_key > der` and make sure it follows the `\xNN\xNN.....\xNN` format

## CT Hammer ##
This needs to be run from the CT repo within the GOPATH structure.
1. Launch a gossec shell with `dc run gossec bash`. The only reason we need this shell is because the script requires the GOPATH setup (used in Go1.11 and before) but the ct-go/ps4ct repo setup does not.
2. Modify the `./trillian/integration/demo-hammer.sh` script with:
  * `tree_id` => obtain by ssh-ing to `ctservera`. Then, `dc logs ctserver | head -20 | grep tree_id`
  * `server_ip` => as of writing, `athos` is available at `40.71.200.117`
  * `prefix` => `athos`
3. Run `./trillian/integration/demo-hammer.sh` from the ct-go project root.
4. Periodically, the file will show how many certificates are on the server. Stop at an appropriate number.

## Gossip ##
### gRPC Calls ###
- turn on debugging with these env variables: `GRPC_GO_LOG_VERBOSITY_LEVEL=99 GRPC_GO_LOG_SEVERITY_LEVEL=info`
