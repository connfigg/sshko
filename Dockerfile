FROM alpine:3.20

RUN apk update && apk add --no-cache \
    openssh \
    stunnel \
    bash \
    tzdata

RUN ssh-keygen -A && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# I-set ang custom banner at i-configure sa sshd_config
COPY banner.txt /etc/banner.txt
RUN echo "Banner /etc/banner.txt" >> /etc/ssh/sshd_config

# Bagong user at password (con / gcp)
RUN adduser -D -s /bin/bash con && \
    echo "con:gcp" | chpasswd

EXPOSE 443 22

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
