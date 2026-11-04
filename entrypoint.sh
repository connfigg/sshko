#!/bin/bash
/usr/sbin/sshd -D &
exec go-websocket-tunnel --listen 0.0.0.0:8080 --path /ssh-con --forward 127.0.0.1:22
