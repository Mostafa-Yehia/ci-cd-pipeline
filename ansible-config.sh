#!/bin/bash

mkdir -p /var/jenkins_home/ansible/

tee /var/jenkins_home/ansible/inventory <<EOF

[default]
private
localhost

EOF

tee /var/jenkins_home/ansible/ansible.cfg <<EOF

[defaults]
inventory = inventory

EOF

tee /var/jenkins_home/ansible/bootstrap.yml <<EOF

---
- name: bootstrap
  hosts: private
  become: true
  tasks:
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
          
    - name: Download jenkins agent.jar file
      get_url:
        url: $1
        dest: /home/jenkins/agent.jar
        mode: '0777'
      register: agent
        
    - name: executing agent.jar file
      command: java -jar /home/jenkins/agent.jar
      when: agent.changed

EOF

su jenkins
whoami
ansible-playbook -i /var/jenkins_home/ansible/inventory /var/jenkins_home/ansible/bootstrap.yml
