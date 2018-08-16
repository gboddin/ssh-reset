# SSH-reset

Simple docker image to reset SSH passwords.

Works when :

 - normal situations
 - password needs to be reset when age = 0

## Usage 

```bash
docker run -e SSH_HOSTNAME=my-awesome-server.com -e SSH_USERNAME=user -e SSH_PASSWORD=Wonderful2 -e SSH_NEW_PASSWORD=Wonderful3 gboo/ssh-reset
```
