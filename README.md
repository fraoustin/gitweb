# Docker Image for gitweb

generate a nginx server with git server and gitweb for ihm on http://127.0.0.1/

load when start image load file in

- /usr/share/gitweb/docker-entrypoint.pre
- /usr/share/gitweb/docker-entrypoint.post

## Parameter

- SET_CONTAINER_TIMEZONE (false or true) manage time of container
- CONTAINER_TIMEZONE timezone of container

## Command

- addrepos: add repository
- addauth : add user for git
- rmrepos : remove repository
- rmauth : remove user

## Usage

Sample of Dockerfile

    FROM fraoustin/gitweb
    COPY ./00_init.sh /usr/share/gitweb/docker-entrypoint.pre/00_init.sh
    RUN chmod +x -R /usr/share/gitweb/docker-entrypoint.pre

File 00_init.sh

    #!/bin/bash
    REPOS='/var/lib/git/test.git'
    if [ ! -d $REPOS ]; then
        addrepos test
        cd $REPOS
        chmod -R g+ws .
        chgrp -R nginx .
    fi
    addauth $GITUSER $GITPASSWORD

build image mygit

    docker build -t mygit .

run image mygit

    docker run -d -e "CONTAINER_TIMEZONE=Europe/Paris" -e "GITUSER=gituser" -e "GITPASSWORD=gitpassword" --name test -p 80:80 mygit


