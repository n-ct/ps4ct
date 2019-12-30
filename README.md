# Provable Security For Certificate Transparency #

This repository runs a full Certificate Transparency Personality.

## Checklist ##
[X] Trillian gRPC API
[X] CT <-> Trillian using default config
[ ] Custom CT Configuration, Keys
[ ] "One-click" Deployement


## Deploy Instructions ##

*Note*: `alias dc=docker-compose`

1. Build docker images `dc build`
2. Start Mysql Container `dc up -d mysql`
3. Start Trillian Log Server Container `dc run tlserver`. In the container shell:
    a. Reset Database `./scripts/resetdb.sh`
    b. Start Server `trillian_log_server --config=/server.cfg`
4. Start Trillian Log Signer Container `dc run tlsigner`. In the container shell:
    a. Start the signer `trillian_log_signer --config=/signer.cfg`
5. Note the container id for "tlserver" using `docker container ls`. This container ID serves as its hostname on the network.
6. Start a Core Container `dc run core` (this is an extra computer to do our dirty work). In the container shell:
    a. Install the CreateTree command  `go install ./cmd/createtree/`
    b. Create a Tree `export TREE_ID=$(createtree --admin_server=<TLSERVER_CONTAINER_ID>:8090 --private_key_format=PrivateKey --pem_key_path=/go/src/github.com/google/trillian/testdata/log-rpc-server.privkey.pem --pem_key_password=towel --signature_algorithm=ECDSA) && echo $TREE_ID`
7. Start CT Server Container `dc run ct`. In the container shell:
    a. edit "./trillian/integration/demo-script.sh" to run as desired (vim is installed)
        i. Ensure that `tree id` variable is hardcoded to the value coped from step 5.
