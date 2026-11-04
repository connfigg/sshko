FROM alpine:3.20
RUN apk update && apk add --no-cache openssh curl bash tzdata ca-certificates
RUN ssh-keygen -A && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin no" >> /etc/ssh/sshd_config
RUN curl -L --insecure -o /usr/local/bin/ws-tunnel-go \
  https://github.com/ago1024/ws-tunnel-go/releases/download/v0.1.2/ws-tunnel-go-linux-amd64
RUN chmod +x /usr/local/bin/ws-tunnel-go
RUN adduser -D -s /bin/bash con && \
    echo "con:gcp" | chpasswd
EXPOSE 8080
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
