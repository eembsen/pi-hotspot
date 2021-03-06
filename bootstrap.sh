#!/bin/sh
set -e

. ./bootstrap.conf

echo 'Syncing Ansible roles'
rsync -a --delete -e "ssh -i ${PRIVATE_KEY}" --rsync-path='sudo rsync' ansible/roles pi@${IPADDRESS}:/etc/ansible/ > /dev/null 2>&1
echo 'Syncing Ansible config'
rsync -a --delete -e "ssh -i ${PRIVATE_KEY}" --rsync-path='sudo rsync' ansible/config/* pi@${IPADDRESS}:/etc/ansible/ > /dev/null 2>&1

echo 'Installing sshpass (if needed)'
ssh -i ${PRIVATE_KEY} ${USERNAME}@${IPADDRESS} 'if [ ! -f /usr/bin/sshpass ]; then sudo apt-get install sshpass; fi' > /dev/null 2>&1
echo 'Installing pip (if needed)'
ssh -i ${PRIVATE_KEY} ${USERNAME}@${IPADDRESS} 'if [ ! -f /usr/bin/pip ]; then sudo apt-get install python-pip; fi' > /dev/null 2>&1
echo 'Installing markupsafe (if needed)'
ssh -i ${PRIVATE_KEY} ${USERNAME}@${IPADDRESS} 'sudo pip install markupsafe' > /dev/null 2>&1
echo 'Installing ansible (if needed)'
ssh -i ${PRIVATE_KEY} ${USERNAME}@${IPADDRESS} 'if [ ! -f /usr/local/bin/ansible ]; then sudo pip install ansible; fi' > /dev/null 2>&1

echo 'Run Ansbile playbook'
ssh -i ${PRIVATE_KEY} ${USERNAME}@${IPADDRESS} 'ansible-playbook /etc/ansible/site.yml'
