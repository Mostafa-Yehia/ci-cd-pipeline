#!/bin/bash

mkdir -p /var/jenkins_home/jars/

if [ ! -f /var/jenkins_home/jars/jenkins-cli.jar ]

then
    
    tee /var/jenkins_home/ansible/add-node.yml <<EOF
---
- name: bootstrap
  become: true
  hosts: localhost
  tasks:
    - name: Download jenkins-cli.jar file
      get_url:
        url: $1
        dest: /var/jenkins_home/jars/jenkins-cli.jar
        mode: '0777'
EOF

fi
