FROM nginx:stable

LABEL maintainer "fraoustin@gmail.com"

COPY ./src/default.conf /etc/nginx/conf.d/default.conf

COPY ./src/entrypoint.sh /entrypoint.sh 
RUN chmod +x /entrypoint.sh 

ENV SET_CONTAINER_TIMEZONE false 
ENV CONTAINER_TIMEZONE "" 

RUN apt-get -qq update 
RUN apt-get -qq install -y \
    bash \
    apache2-utils \
    fcgiwrap \
    git \
    git-core \
    gitweb \
    highlight \
    libcgi-pm-perl \
    mime-support \
    spawn-fcgi 
RUN apt-get autoclean 
RUN rm -rf /var/lib/apt/lists/*

# manage user load fcgiwrap
RUN sed -i "s/www-data/nginx/g" /etc/init.d/fcgiwrap

# manage start container
RUN mkdir /usr/share/gitweb/docker-entrypoint.pre
RUN mkdir /usr/share/gitweb/docker-entrypoint.post
COPY ./src/00_init.sh /usr/share/gitweb/docker-entrypoint.pre/00_init.sh
RUN chmod +x -R /usr/share/gitweb/docker-entrypoint.pre

# add cmd gitweb
COPY ./src/cmd/addrepos.sh /usr/bin/addrepos
COPY ./src/cmd/addauth.sh /usr/bin/addauth
COPY ./src/cmd/rmrepos.sh /usr/bin/rmrepos
COPY ./src/cmd/rmauth.sh /usr/bin/rmauth
RUN chmod +x /usr/bin/addrepos
RUN chmod +x /usr/bin/addauth
RUN chmod +x /usr/bin/rmrepos
RUN chmod +x /usr/bin/rmauth

# manage default value
ENV GITUSER gituser
ENV GITPASSWORD gitpassword
ENV GITHIGHLIGHT 0

# add ihm mdl
ENV IHM no-mdl
COPY ./src/ihm /mdl-ihm
RUN cp /usr/share/gitweb/static/gitweb.css /usr/share/gitweb/static/gitweb.css.original
RUN mkdir /usr/share/gitweb/ihm

# force push to upstream
WORKDIR /opt/gitweb/
COPY ./src/hooks/post-receive /opt/gitweb/post-receive
RUN chmod +x /opt/gitweb/post-receive
ENV FORCEPUSH ""

# Setting base url via Docker
ENV my_uri /

VOLUME /opt/gitweb/remote/

VOLUME /var/lib/git/

WORKDIR /var/lib/git/

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]

CMD ["app"]
