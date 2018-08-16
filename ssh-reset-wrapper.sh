#!/bin/sh
set -e

ssh-reset-wrapper.expect

echo -n "Testing connection : "

sshpass -p "${SSH_NEW_PASSWORD}" ssh -T ${SSH_USERNAME}@${SSH_HOSTNAME} "echo OK"

if [ ! -z "${SSH_AUTHORIZED_KEYS}" ]; then
  # Skip if authorized_keys is already there
  if sshpass -p "${SSH_NEW_PASSWORD}" ssh -T ${SSH_USERNAME}@${SSH_HOSTNAME} 'ls ${HOME}/.ssh/authorized_keys' 1> /dev/null ; then
    if [ "${FORCE_KEY_RESET}" != "true" ]; then
      echo "Authorized keys already present, not implementing"
      exit 0
    fi
  fi
  echo -n "Public keys specified, adding : "
  set +e
  sshpass -p "${SSH_NEW_PASSWORD}" ssh -T ${SSH_USERNAME}@${SSH_HOSTNAME} 'mkdir ${HOME}/.ssh' 2> /dev/null
  set -e
  echo "${SSH_AUTHORIZED_KEYS}" | sshpass -p "${SSH_NEW_PASSWORD}" ssh -T ${SSH_USERNAME}@${SSH_HOSTNAME} 'cat >> ${HOME}/.ssh/authorized_keys'
  sshpass -p "${SSH_NEW_PASSWORD}" ssh -T ${SSH_USERNAME}@${SSH_HOSTNAME} 'chmod 640 ${HOME}/.ssh/authorized_keys'
  sshpass -p "${SSH_NEW_PASSWORD}" ssh -T ${SSH_USERNAME}@${SSH_HOSTNAME} 'chmod 750 ${HOME}/.ssh'
  echo "OK"
fi