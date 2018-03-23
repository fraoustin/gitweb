#!/bin/bash

if [ ! -z "$GITPROJECT" ]; then
    REPOS='/var/lib/git/'$GITPROJECT'.git'
    if [ ! -d $REPOS ]; then
        addrepos $GITPROJECT
        cd $REPOS
        chmod -R g+ws .
        chgrp -R nginx .
    fi
    addauth $GITUSER $GITPASSWORD
fi    
