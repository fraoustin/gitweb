#!/bin/bash

DIR="/var/lib/git/"

log_run(){
    echo -e "$@"
    eval $@
}

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
        chmod -R g+ws .
        chgrp -R nginx .
        if [ ! -f /opt/gitweb/remote/remotes.txt ]; then
            exit 0
        fi
        log_run cp /opt/gitweb/post-receive $REPOS/hooks/post-receive
        log_run chgrp nginx $REPOS/hooks/post-receive
        log_run chmod 0755 $REPOS/hooks/post-receive
        log_run chmod g+ws $REPOS/hooks/post-receive
        while read line
        do
            if [ -z "${line}" ];then
                continue
            fi
            # eg: git remote add gitweb-test1 https://gituser:gitpassword@gitweb-test1/test.git
            log_run git remote add ${line}/$(basename $(pwd))
        done < /opt/gitweb/remote/remotes.txt
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
