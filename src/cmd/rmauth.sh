#!/bin/bash
FPASS="/etc/nginx/.htpasswd"
 
error(){ 
    	echo "ERROR : parameters invalid !" >&2 
    	exit 1 
} 

usage(){ 
    	echo "Usage: rmauth user" 
    	echo "--help or -h : view help" 
} 

load(){
	if [ -f $FPASS ]; then
  		htpasswd -bD $FPASS $1
	fi
}

# no parameters
[[ $# -ne 1 ]] && error

case "$1" in
        --help)
            usage
            ;;
         
        -h)
            usage
            ;;
         
        *)
            load $1
 
esac
