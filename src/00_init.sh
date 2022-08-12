#!/bin/bash
if [ ! -z "$GITPROJECT" ]; then
    REPOS='/var/lib/git/'$GITPROJECT'.git'
    if [ ! -d $REPOS ]; then
        addrepos $GITPROJECT
        cd $REPOS
    fi
fi
if [ ! -z "$GITUSER" ]; then
    addauth $GITUSER $GITPASSWORD
fi 
