#!/bin/bash

if [ ! -f /etc/stunnel/stunnel.pem ]; then
    openssl req -new -x509 -days 365 -nodes \
        -out /etc/stunnel/stunnel.pem \
        -keyout /etc/stunnel/stunnel.pem \
        -subj "/CN=ssh-tls/C=PH/ST=Davao/L=Davao/O=ConFig/OU=IT"
    chmod 600 /etc/stunnel/stunnel.pem
fi

# Simulan ang SSH Server
/usr/sbin/sshd

# Simulan ang Stunnel sa port 8080 para sumunod sa Cloud Run requirement
exec stunnel /etc/stunnel/stunnel.conf
