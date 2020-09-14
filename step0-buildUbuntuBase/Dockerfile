FROM ubuntu:18.04

MAINTAINER <erick.zhttty@gmail.com>

WORKDIR /root

# copy resources 
COPY conf/ssh_config /tmp/

# install vim, openssh-server
RUN apt-get update && apt-get install -y vim openssh-server && \

# ssh without key
ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \

mv /tmp/ssh_config ~/.ssh/config



