# Docker Image for gitweb

generate a nginx server with git server and gitweb for ihm on http://127.0.0.1/

load when start image load file in

- /usr/share/gitweb/docker-entrypoint.pre
- /usr/share/gitweb/docker-entrypoint.post

## Parameter

- SET_CONTAINER_TIMEZONE (false or true) manage time of container
- CONTAINER_TIMEZONE timezone of container
- GITPROJECT
- GITUSER (default gituser)
- GITPASSWORD (default gitpassword)
- IHM (default "")

## Volume

- /var/lib/git

## Port

- 80 for gitweb

## Command

- addrepos: add repository
- addauth : add user for git
- rmrepos : remove repository
- rmauth : remove user

## Usage direct

run image fraoustin/gitweb

    docker run -d -e "CONTAINER_TIMEZONE=Europe/Paris" -e "GITPROJECT=test" -v <localpath>:/var/lib/git --name test -p 80:80 fraoustin/gitweb

user default is gituser and password default is gitpassword

you use http://localhost/ for access gitweb

you can clone project

    git clone http://gituser:gitpassword@localhost/test.git

You can change user and password by variable environment


## Usage by Dockerfile

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

    docker run -d -e "CONTAINER_TIMEZONE=Europe/Paris" -e "GITUSER=gituser" -e "GITPASSWORD=gitpassword" -v <localpath>:/var/lib/git --name test -p 80:80 mygit




## IHM material design

If you want use a new design for ihm, you can use IHM variable

- IHM = mdl

    docker run -d -e "CONTAINER_TIMEZONE=Europe/Paris" -e "IHM=mdl" -e "GITPROJECT=test" -v <localpath>:/var/lib/git --name test -p 80:80 fraoustin/gitweb

