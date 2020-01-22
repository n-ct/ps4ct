# Provable Security For Certificate Transparency #

This repository runs a full Certificate Transparency Personality.

This repo uses submodules, and should be cloned as `git clone --recurse-submodules URL`

## Checklist ##
[X] Trillian gRPC API\
[X] CT <-> Trillian using default config\
[ ] Custom CT Configuration, Keys\
[X] "One-click" Deployement

## Deploy Instructions ##

*Note*: `alias dc=docker-compose`

0. Build docker images `dc build`
1. Start CT-server Container `dc run ctserver`. This starts and configures mysql and a trillian log server automatically. 
2. Wait for ~2m. Check `dc logs tlserver` and `dc logs tlsigner`. Installation should complete, 
3. In the CT-server shell, run `/docker-entrypoint.sh --install-ct --ctserver-demo`. This runs the demo-script and should print successful output.

### Troublshooting ###
Run the following commands if docker does not work as expected. this will wipe the docker slate clean

```
dc down -v --rmi all && yes | d system prune && yes | d volume prune

```
