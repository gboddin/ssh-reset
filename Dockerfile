FROM alpine:latest

ENV SSH_HOSTNAME localhost
ENV SSH_USERNAME user
ENV SSH_PASSWORD none
ENV SSH_NEW_PASSWORD unsafe

RUN apk add --no-cache expect openssh-client sshpass

ADD ssh-reset-wrapper.* /bin/
CMD /bin/ssh-reset-wrapper.sh