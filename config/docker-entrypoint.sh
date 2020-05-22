#!/bin/bash
set -e

function install_trillian(){
    echo "[1 of 3] installing tlserver"
    go install ./cmd/trillian_log_server
    echo "[2 of 3] installing tlsigner"
    go install ./cmd/trillian_log_signer
    echo "[3 of 3] installing create-tree utility"
    go install ./cmd/createtree
}

function install_ct(){
    echo "[1 of 3] install ct_server"
    go install ./trillian/ctfe/ct_server
    echo "[2 of 3] install ct_hammer"
    go install ./trillian/integration/ct_hammer
    echo "[3 of 3] install ct_hammer"
    go install github.com/google/trillian/cmd/createtree
}

function resetdb(){
    echo "resetting db..."
    sh -c "./scripts/resetdb.sh --force"
}

function create_tree(){
    echo "creating merkle tree"
    # admin_server is hardlinked to tlserver hostname
    # this will print out the tree_id created. required for later steps
    createtree --admin_server=tlserver:8090 --private_key_format=PrivateKey --pem_key_path=/go/src/github.com/zorawar87/trillian/testdata/log-rpc-server.privkey.pem --pem_key_password=towel --signature_algorithm=ECDSA
}

function tlserver(){
    echo "starting tlserver..."
    sh -c "trillian_log_server --config=/server.cfg"
}

function tlsigner(){
    echo "waiting for tlserver to be setup"
    sh -c "/wait-for-it.sh -t 0 tlserver:8090 -- echo 'tlserver is up' && trillian_log_signer --config=/signer.cfg"
}

function ctserver_demo(){
    echo "ct_server is (probably) good to go!"
    sh -c "./trillian/integration/demo-script.sh"
}

function ctserver(){
    echo "waiting for tlserver to be setup"
    sh -c "/wait-for-it.sh -t 0 tlserver:8090 -- echo 'tlserver is up' && ./trillian/integration/demo-run-ct.sh"
}

function gossecserver(){
    echo "[1 of 1] (re)install gosmin"
    go install ./gossip/minimal/gosmin
    echo "Starting gossec server..."
    gosmin --config=/gossec.cfg --metrics_endpoint=localhost:6962 --alsologtostderr -v=1
}

while test $# -gt 0
do
    case "$1" in
        mysql) mysql -utest -pzaphod -hmysql cttest
            ;;
        bash) bash
            ;;
        --install-trillian) install_trillian
            ;;
        --install-ct) install_ct
            ;;
        --resetdb) resetdb
            ;;
        --createtree) create_tree
            ;;
        --tlserver) tlserver
            ;;
        --tlsigner) tlsigner
            ;;
        --ctserver) ctserver
            ;;
        --gossec) gossecserver
            ;;
        --ctserver-demo) ctserver_demo
            ;;
        -h) echo "/docker-entrypoint.sh [--install-trillian|--install-ct|--resetdb|--createtree|--tlserver|--tlsigner|--ctserver|--gossec] [mysql|bash]"
            ;;
        *) echo "ignoring argument $1; try /docker-entrypoints.sh -h"
            ;;
    esac
    shift
done


exec "$@"
