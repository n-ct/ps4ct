# Provable Security For Certificate Transparency #

This repository runs a full Certificate Transparency Personality.

## Checklist ##
[X] Trillian gRPC API\
[X] CT <-> Trillian using default config\
[ ] Custom CT Configuration, Keys\
[ ] "One-click" Deployement


## Deploy Instructions ##

*Note*: `alias dc=docker-compose`

1. Build docker images `dc build`
2. Start CT-personality Container `dc run ct`. This starts and configures mysql and a trillian log server automatically. 
3. In another shell, check `dc logs tlserver` and ensure that the database was reset and the the server is up and running. This step is necessary for the moment because a successful start depends on how long mysql and tlserver take to set up, rather than completion signals 
4. In the second shell, start a log signer with `dc up -d tlsigner`. Check `dc logs tlsigner` to check status.
5. In the CT-personality shell, run `/docker-entrypoint.sh --install-ct --ctserver`. This runs the demo-script and should print successful output.
