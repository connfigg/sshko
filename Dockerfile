FROM alpine:3.20
RUN apk update && apk add --no-cache openssh wget bash tzdata
RUN ssh-keygen -A && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin no" >> /etc/ssh/sshd_config
# Download binary
RUN wget -O /usr/local/bin/go-websocket-tunnel \
  https://github.com/ago1024/ws-tunnel-go/releases/download/v0.1.2/ws-tunnel-go-linux-amd64
RUN chmod +x /usr/local/bin/go-websocket-tunnel
RUN adduser -D -s /bin/bash con && \
    echo "con:gcp" | chpasswd
EXPOSE 8080
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
