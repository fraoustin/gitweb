#!/bin/bash
set -e

if [ $CONTAINER_TIMEZONE ] &&  [ "$SET_CONTAINER_TIMEZONE" = "false" ]; then
    echo ${CONTAINER_TIMEZONE} >/etc/timezone && dpkg-reconfigure -f noninteractive tzdata
    echo "Container timezone set to: $CONTAINER_TIMEZONE"
    export SET_CONTAINER_TIMEZONE=true
else
    echo "Container timezone not modified"
fi

if [ "$1" = 'app' ]; then
    /bin/run-parts --verbose --regex '\.(sh)$' "/usr/share/gitweb/docker-entrypoint.pre"
    # del IHM

    if [ "$IHM" = 'mdl' ]; then
        # add IHM
        ./src/ihm/static/* /usr/share/gitweb/static/
        ./src/ihm/*.html /usr/share/gitweb/
        echo '$home_text="hometext.html";' >> /etc/gitweb.conf
        echo '$site_header="header.html";' >> /etc/gitweb.conf
        echo '$site_footer="footer.html";' >> /etc/gitweb.conf
        cat /usr/share/gitweb/headstring.html >> /etc/gitweb.conf
    fi  
    service fcgiwrap start
    nginx -g "daemon off;"
    /bin/run-parts --verbose --regex '\.(sh)$' "/usr/share/gitweb/docker-entrypoint.post"
fi

exec "$@"
