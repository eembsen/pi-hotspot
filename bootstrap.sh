#!/bin/sh
set -e

. ./bootstrap.conf

echo 'Syncing Ansible roles'
rsync -a -e "ssh -i ${PRIVATE_KEY}" --rsync-path='sudo rsync' ansible/roles pi@192.168.100.114:/etc/ansible/ > /dev/null 2>&1
echo 'Syncing Ansible config'
rsync -a -e "ssh -i ${PRIVATE_KEY}" --rsync-path='sudo rsync' ansible/config/* pi@192.168.100.114:/etc/ansible/ > /dev/null 2>&1

echo 'Installing sshpass (if needed)'
ssh -i ${PRIVATE_KEY} ${USERNAME}@${IPADDRESS} 'if [ ! -f /usr/bin/sshpass ]; then sudo apt-get install sshpass; fi' > /dev/null 2>&1
echo 'Installing ansible (if needed)'
ssh -i ${PRIVATE_KEY} ${USERNAME}@${IPADDRESS} 'if [ ! -f /usr/local/bin/ansible ]; then sudo pip install ansible; fi' > /dev/null 2>&1

echo 'Run Ansbile playbook'
ssh -i ${PRIVATE_KEY} ${USERNAME}@${IPADDRESS} 'ansible-playbook /etc/ansible/site.yml'
