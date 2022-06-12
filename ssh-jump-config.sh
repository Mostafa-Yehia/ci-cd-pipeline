#!/bin/bash

private=$2

mkdir -p /var/jenkins_home/.ssh/

tee /var/jenkins_home/.ssh/config <<EOF

Host *
    Port 22
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
    ServerAliveInterval 60
    ServerAliveCountMax 30

Host bastion
    HostName $1
    User ubuntu
    IdentityFile private.pem
    AddKeysToAgent yes

Host private
    HostName $2
    User ubuntu
    IdentityFile private.pem
    ProxyCommand ssh bastion -W %h:%p

EOF

grep -qxF "${private}    private" /etc/hosts || echo "${private}    private" >> /etc/hosts
