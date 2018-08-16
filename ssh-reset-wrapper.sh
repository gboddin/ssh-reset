#!/usr/bin/expect -f

spawn ssh -t -l $env(SSH_USERNAME) -o StrictHostKeyChecking=no -o PreferredAuthentications=password -o PubkeyAuthentication=no $env(SSH_HOSTNAME) passwd
expect "assword:"
send "$env(SSH_PASSWORD)\r"
expect "assword:"
send "$env(SSH_PASSWORD)\r"
expect "password:"
send "$env(SSH_NEW_PASSWORD)\r"
expect "password:"
send "$env(SSH_NEW_PASSWORD)\r"
expect eof