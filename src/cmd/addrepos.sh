#!/bin/bash
DIR="/var/lib/git/"
 
error(){ 
    	echo "ERROR : parameters invalid !" >&2 
    	exit 1 
} 

usage(){ 
    	echo "Usage: addrepos NameOfRepository" 
    	echo "--help or -h : view help" 
} 

load(){
	REPOS=$DIR$1.git
	if [ ! -d $REPOS ]; then
  		mkdir $REPOS
		cd $REPOS
		git init --bare
		echo "$1" > description
		cp /opt/gitweb/post-receive $REPOS/hooks/post-receive
		chgrp -R nginx $REPOS
		chmod 0755 $REPOS/hooks/post-receive
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
