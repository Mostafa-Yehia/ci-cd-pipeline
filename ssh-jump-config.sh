#!/bin/bash

public=$1
private=$2

mkdir -p ~/.ssh/

tee ~/.ssh/config <<EOF

Host *
    Port 22
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
    ServerAliveInterval 60
    ServerAliveCountMax 30

Host bastion
    HostName $1
    User ubuntu
    IdentityFile ~/.ssh/private.pem
    AddKeysToAgent yes

Host private
    HostName $2
    User ubuntu
    IdentityFile ~/.ssh/private.pem
    ProxyCommand ssh bastion -W %h:%p

EOF

grep -qxF "${private}    private" /etc/hosts || echo "${private}    private" >> /etc/hosts
grep -qxF "${public}    bastion" /etc/hosts || echo "${public}    bastion" >> /etc/hosts
