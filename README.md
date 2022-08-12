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
- FORCEPUSH ("" or every not blank string) manage force push to upstream when Downstream branch push

## Volume

- git project: */var/lib/git/*
- git remove add: */opt/gitweb/remote/*

## Port

- 80 for gitweb

## Command

- addrepos: add repository
- addauth : add user for git
- rmrepos : remove repository
- rmauth : remove user

## Usage direct

run image fraoustin/gitweb
```bash
    docker run -d -e "CONTAINER_TIMEZONE=Europe/Paris" -e "GITPROJECT=test" \
        -v <localpath>:/var/lib/git --name test -p 80:80 fraoustin/gitweb
```
> use <kbd>^</kbd> for *CMD* OR <kbd>`</kbd> for *Powershell* 

user default is gituser and password default is gitpassword 
- You can change user and password by variable environment

you use http://localhost/ for access gitweb

you can add remote
```bash
    git remote add origin http://gituser:gitpassword@localhost/test.git
```
you can push project

when fist push
```bash
    git push --set-upstream origin master
```
every next time push
```bash
    git push
```
or manual push
```bash
    git push origin # remote name
```
you can clone project
```bash
    git clone http://gituser:gitpassword@localhost/test.git
```
you can pull project when upstream update
```bash
    git pull
```
more use see:
- https://git-scm.com/doc
- https://www.runoob.com/git/git-tutorial.html



## Add upstream and push

creat *remotes.txt*  
eg:
```text
gitweb-test1       https://gituser:gitpassword@gitweb-test1
gitweb-test2       https://gituser:gitpassword@gitweb-test2
gitweb-test3       https://gituser:gitpassword@gitweb-test3
```
run image fraoustin/gitweb
```bash
    docker run -d -e "CONTAINER_TIMEZONE=Europe/Paris" -e "GITPROJECT=test" \
        -e FORCEPUSH='not_blank_string' \ 
        -v <localpath>:/var/lib/git/ \
        -v </path/to/remote/>:/opt/gitweb/remote/ \
        --name test -p 80:80 fraoustin/gitweb
```
if don't want force push, **DO NOT** set environment: FORCEPUSH  

- when run `addrepos ${project}` ,
    - will add hook: `hooks/post-receive`
    - will add remote each: `add remote gitweb-test1 https://gituser:gitpassword@gitweb-test1/${project}.git` ...
- when downstream push
    - gitweb will push to upstreams each: `git push [-f] --all gitweb-test1` ...

## Setting base url via Docker environment

use environment *URLPATH* to set base url 

## Usage by Dockerfile

Sample of Dockerfile
```Dockerfile
    FROM fraoustin/gitweb
    COPY ./00_init.sh /usr/share/gitweb/docker-entrypoint.pre/00_init.sh
    RUN chmod +x -R /usr/share/gitweb/docker-entrypoint.pre
```
File 00_init.sh
```bash
    #!/bin/bash
    REPOS='/var/lib/git/test.git'
    if [ ! -d $REPOS ]; then
        addrepos test
        cd $REPOS
        chmod -R g+ws .
        chgrp -R nginx .
    fi
    addauth $GITUSER $GITPASSWORD
```
build image mygit
```bash
    docker build -t mygit .
```
run image mygit
```bash
    docker run -d -e "CONTAINER_TIMEZONE=Europe/Paris" -e "GITUSER=gituser" -e "GITPASSWORD=gitpassword" \
        -v <localpath>:/var/lib/git --name test -p 80:80 mygit
```



## IHM material design

If you want use a new design for ihm, you can use IHM variable

- IHM = mdl
```bash
    docker run -d -e "CONTAINER_TIMEZONE=Europe/Paris" -e "IHM=mdl" -e "GITPROJECT=test" -v <localpath>:/var/lib/git --name test -p 80:80 fraoustin/gitweb
```
