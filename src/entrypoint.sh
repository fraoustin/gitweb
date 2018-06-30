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
    sed '/^# add conf for IHM mdl/ d' /etc/gitweb.conf
    sed '/^$home_text/ d' /etc/gitweb.conf
    sed '/^$site_header/ d' /etc/gitweb.conf
    sed '/^$site_footer/ d' /etc/gitweb.conf
    sed '/^$site_html_head_string/ d' /etc/gitweb.conf
    rm /usr/share/gitweb/static/gitweb.css
    cp /usr/share/gitweb/static/gitweb.css.original /usr/share/gitweb/static/gitweb.css
    if [ "$IHM" = 'mdl' ]; then
        # add IHM
        cp -R /mdl-ihm/* /usr/share/gitweb/ihm/
        echo '' >> /etc/gitweb.conf
        echo '# add conf for IHM mdl' >> /etc/gitweb.conf
        echo '$home_text="ihm/hometext.html";' >> /etc/gitweb.conf
        echo '$site_header="ihm/header.html";' >> /etc/gitweb.conf
        echo '$site_footer="ihm/footer.html";' >> /etc/gitweb.conf
        cat /usr/share/gitweb/ihm/headstring.conf >> /etc/gitweb.conf
        cp /usr/share/gitweb/ihm/gitweb.css /usr/share/gitweb/static/gitweb.css
    fi  
    service fcgiwrap start
    nginx -g "daemon off;"
    /bin/run-parts --verbose --regex '\.(sh)$' "/usr/share/gitweb/docker-entrypoint.post"
fi

exec "$@"
