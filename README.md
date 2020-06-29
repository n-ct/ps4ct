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

## Deterlab Testing ##
Read the [core quick-start](https://docs.deterlab.net/core/core-quickstart/) and [core guide](https://docs.deterlab.net/core/core-guide/) for official, up-to-date instructions.

In our initial explorations of docker, we decided to stick to "Deterlab core" because "Deterlab Container and Orchestrator" added an extra layer of complexity that could not be justified.

### Creating an Experiment ###
An experiment is a means to test set configuration of distributed machines. The type of machines, how they are connected (networked), the latency between them and other features are specified in a Network Simulator file. See `./deterlab` or "Design the topology" section of the core guide.

Our `RouteSec` project (owned by Prof. Herzberg) includes a `ps4ct` experiment that we used to get our software working on deterlab. A new experiment can also be created.

"Swap In" an experiment to deploy the network topology in deterlab's cloud.

### Accessing the deterlab environment ###
#### The Control Server ####
The "Control Server" is an internet-connected machine without sudo privileges. Any information in the home-folder, /proj, and /share (like our git repo) is mounted and accessible to experiment nodes.
SSH into the experiment control server: `ssh <username>@users.isi.deterlab.net`

#### Experiment Nodes ####
A node is identified by `<node_name>.<experiment_name>.<project_name>.isi.deterlab.net`. From within the control server, the `isi.deterlab.net` suffix can be omitted. Experiment nodes are disconnected from the internet and are exclusively connected to the control server and other machines as specified in the experiment topology. sudo privileges are available here.

SSH into an experiment node: `ssh <username>@<node_name>.<experiment_name>.<project_name>.isi.deterlab.net`

The `RouteSec` project has an experiment `ps4ct`, which specifies a basic network topology including two nodes `ctservera` and `monitora`.

[Read more about using nodes](https://docs.deterlab.net/core/using-nodes/)

### Accessing the deterlab environment with docker enabled ###
1. SSH into an experiment node by creating a Reverse Tunnel so that we can install a docker image from Docker Hub: `ssh -J <user_name>@users.deterlab.net -R 3128 <username>@<node_name>.<experiment_name>.<project_name>.isi.deterlab.net`
2. On the experiment node:
    - Install docker `sudo apt install docker.io`
    - `sudo mkdir -p /etc/systemd/system/docker.service.d/`
    - Configure a proxy for docker `sudo vim /etc/systemd/system/docker.service.d/https-proxy.conf` and add
    ```
    [Service]
    Environment="HTTPS_PROXY=socks5://localhost:3128"
    ```
    - Reload the systemd config `sudo systemctl daemon-reload`
    - Restart docker `sudo systemctl restart docker`
    - Search Docker Hub for images `sudo docker search ps4ct`. If this works, then our proxy for docker is working successfully.
    - Install the ps4ct image: `sudo docker pull zorawarx/ps4ct:1.1` OR build the image locally `cd ps4ct && sudo docker . -t ps4ct`

See this conversation with deterlab support about using docker on deterlab: (https://trac.deterlab.net/ticket/2747)

### Generate Traffic for the Experiment ###
We switched gears before we could focus on generating traffic and actually running/measuring an experiment. There are probably simplifications and missing-steps between simply installing the ps4ct software and running a realistic experiment. [More information](https://docs.deterlab.net/core/generating-traffic/).
