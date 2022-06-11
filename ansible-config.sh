#!/bin/bash

tee /var/jenkins_home/ansible/inventory <<EOF

private

EOF

tee /var/jenkins_home/ansible/ansible.cfg <<EOF

[defaults]
inventory = inventory

EOF

tee /var/jenkins_home/ansible/bootstrap.yml <<EOF

---
- name: bootstrap
  become: true
  hosts: private
  task:
    - name: updating apt & installing needed packages for jenkins
      apt:
        update_cache: yes
        name:
          - git
          - ssh
          - docker.io
          - openjdk-8-jdk
        state: present
          
    - name: creating user jenkins & adding them to docker group
        user:
          name: jenkins
          shell: /bin/bash
          groups: docker
          append: yes
          
    - name: starting ssh service
        service:
          name: ssh
          state: started

EOF
