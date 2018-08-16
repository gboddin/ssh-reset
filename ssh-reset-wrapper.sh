#!/bin/sh
set -e
ssh-reset-wrapper.expect
echo -n "Testing connection : "

sshpass -p "${SSH_NEW_PASSWORD}" ssh ${SSH_USERNAME}@${SSH_HOSTNAME} "echo OK"

if [ ! -z "${SSH_AUTHORIZED_KEYS}" ]; then
  echo -n "Public keys specified, uploading : "
  set +e
  sshpass -p "${SSH_NEW_PASSWORD}" ssh ${SSH_USERNAME}@${SSH_HOSTNAME} 'mkdir ${HOME}/.ssh' 2> /dev/null
  set -e
  echo "${SSH_AUTHORIZED_KEYS}" | sshpass -p "${SSH_NEW_PASSWORD}" ssh ${SSH_USERNAME}@${SSH_HOSTNAME} 'cat >> ${HOME}/.ssh/authorized_keys'
  sshpass -p "${SSH_NEW_PASSWORD}" ssh ${SSH_USERNAME}@${SSH_HOSTNAME} 'chmod 640 ${HOME}/.ssh/authorized_keys'
  sshpass -p "${SSH_NEW_PASSWORD}" ssh ${SSH_USERNAME}@${SSH_HOSTNAME} 'chmod 750 ${HOME}/.ssh'
  echo "OK"
fi