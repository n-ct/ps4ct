#!/bin/bash

ctservera="40.71.200.117"
ctserverb="13.92.181.187"
athos="athos"
gctserver="https://ct.googleapis.com/logs"
argon="argon2020"
cfctserver="https://ct.cloudflare.com/logs"
nimbus="nimbus2020"


function newline(){ echo ""; }

function get(){
    # $1 => IP, $2 = prefix, $3 = operation, $4=verbose
    url="$1/$2/ct/v1/$3"
    echo "--> GET $url"
    if [[ "$4" == "-v" ]]; then
        curl -v $url && newline
    else
        curl $url && newline
    fi
}

function trillian() {
    url="$1:8091/metrics"
    echo "--> GET $url"
    curl -v $url && newline
}

while test $# -gt 0
do
    case "$1" in
        a) get $ctservera":6965" $athos "get-sth"
            ;;
        b) get $ctserverb":6965" $athos "get-sth"
            ;;
        c) get $cfctserver $nimbus "get-sth"
            ;;
        g) get $gctserver $argon "get-sth"
            ;;
        av) get $ctservera":6965" $athos "get-sth" "-v"
            ;;
        bv) get $ctserverb":6965" $porthos "get-sth" "-v"
            ;;
        cv) get $cfctserver $nimbus "get-sth" "-v"
            ;;
        gv) get $gctserver $argon "get-sth" "-v"
            ;;
        bt) trillian $ctserverb
            ;;
        at) trillian $ctservera
            ;;
        -h) echo "/dear-ctserver.sh [a|av|at||b|bv|bt||-h]"
            ;;
        *) echo "ignoring argument $1; try ./dear-ctserver.sh -h"
            ;;
    esac
    shift
done
