# Docker Image for gitweb

generate a nginx server with git server and gitweb for ihm on http://127.0.0.1/

load when start image load file in

- /usr/share/gitweb/docker-entrypoint.pre
- /usr/share/gitweb/docker-entrypoint.post

## Parameter

- SET_CONTAINER_TIMEZONE (false or true) manage time of container
- CONTAINER_TIMEZONE timezone of container

## command

- addrepos: add repository
- addauth : add user for git
- rmrepos : remove repository
- rmauth : remove user
