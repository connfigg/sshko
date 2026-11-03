FROM alpine:3.20

RUN apk update && apk add --no-cache \
    openssh \
    stunnel \
    bash \
    tzdata

RUN ssh-keygen -A && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

COPY banner.txt /etc/banner.txt
RUN echo "Banner /etc/banner.txt" >> /etc/ssh/sshd_config

RUN adduser -D -s /bin/bash con && \
    echo "con:gcp" | chpasswd

# I-expose ang port 8080 para sa Cloud Run
EXPOSE 8080

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
