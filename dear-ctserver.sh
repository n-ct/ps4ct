#!/bin/bash

ctservera="40.71.200.117"
athos="athos"
ctserverb="13.90.199.163"
porthos="porthos"


function newline(){ echo ""; }

function get(){
    # $1 => IP, $2 = prefix, $3 = operation, $4=verbose
    url="$1:6965/$2/ct/v1/$3"
    echo "--> GET $url"
    if [[ "$4" == "-v" ]]; then
        curl -v $url && newline
    else
        curl $url && newline
    fi
}

function get-sth (){
    url="$1:6965/$2/ct/v1/get-sth"
    echo "--> Getting STH for $2 on $1"
    curl $url && newline
}

function trillian() {
    url="$1:8091/metrics"
    echo "--> :8091 GET $url"
    curl -v $url && newline
}

while test $# -gt 0
do
    case "$1" in
        a) get-sth $ctservera $athos
            ;;
        b) get-sth $ctserverb $porthos
            ;;
        av) get $ctservera $athos "get-sth" "-v"
            ;;
        bv) get $ctserverb $porthos "get-sth" "-v"
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
