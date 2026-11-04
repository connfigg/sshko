FROM alpine:3.20
RUN apk update && apk add --no-cache openssh go-websocket-tunnel bash tzdata
RUN ssh-keygen -A && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin no" >> /etc/ssh/sshd_config
RUN adduser -D -s /bin/bash con && \
    echo "con:gcp" | chpasswd
EXPOSE 8080
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
