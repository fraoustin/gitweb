FROM nginx:1.11
MAINTAINER fraoustin@gmail.com

COPY ./src/default.conf /etc/nginx/conf.d/default.conf

COPY ./src/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV SET_CONTAINER_TIMEZONE false 
ENV CONTAINER_TIMEZONE "" 

RUN apt-get update && apt-get install -y \
        apache2-utils \
        fcgiwrap \
        git \
        git-core \
        gitweb \
        highlight \
        libcgi-pm-perl \
        spawn-fcgi \
    && rm -rf /var/lib/apt/lists/* 

#manage user load fcgiwrap
RUN sed -i "s/www-data/nginx/g" /etc/init.d/fcgiwrap

RUN mkdir /usr/share/gitweb/docker-entrypoint.pre
RUN mkdir /usr/share/gitweb/docker-entrypoint.post

# add cmd gitweb
COPY ./src/cmd/addrepos.sh /usr/bin/addrepos
COPY ./src/cmd/addauth.sh /usr/bin/addauth
COPY ./src/cmd/rmrepos.sh /usr/bin/rmrepos
COPY ./src/cmd/rmauth.sh /usr/bin/rmauth
RUN chmod +x /usr/bin/addrepos
RUN chmod +x /usr/bin/addauth
RUN chmod +x /usr/bin/rmrepos
RUN chmod +x /usr/bin/rmauth

VOLUME /var/lib/git
EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
CMD ["app"]
