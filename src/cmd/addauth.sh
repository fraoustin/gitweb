#!/bin/bash
FPASS="/etc/nginx/.htpasswd"
 
error(){ 
    	echo "ERROR : parameters invalid !" >&2 
    	exit 1 
} 

usage(){ 
    	echo "Usage: addauth user password" 
    	echo "--help or -h : view help" 
} 

load(){
	if [ ! -f $FPASS ]; then
  		touch $FPASS
	fi	
	htpasswd -b $FPASS $1 $2 
	if [ "$?" != 0 ] ; then
  		htpasswd -bp $FPASS $1 $2
	fi
}

# no parameters
[[ $# -lt 1 ]] && error

case "$1" in
        --help)
            usage
            ;;
         
        -h)
            usage
            ;;
         
        *)
            [[ $# -ne 2 ]] && error
            load $1 $2
             
esac
