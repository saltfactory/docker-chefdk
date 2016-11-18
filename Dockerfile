FROM ubuntu:trusty

MAINTAINER SungKwang Song <saltfactory@gmail.com>
ENV DEBIAN_FRONTEND noninteractive
ENV USER ubuntu
ENV TERM xterm
ENV TIMEZONE Asia/Seoul
# timezone
RUN echo $TIMEZONE > /etc/timezone && dpkg-reconfigure tzdata

#RUN cd /etc/apt &&  sed -i 's/archive.ubuntu.com/ftp.daum.net/g' sources.list

RUN apt-get update
RUN apt-get install curl vim openssh-server -y
RUN mkdir /var/run/sshd
RUN useradd $USER -m -s /bin/bash && echo "$USER:$USER" | chpasswd
RUN echo "$USER    ALL=(ALL)       ALL" >> /etc/sudoers.d/$USER

# chefdk
RUN curl -L https://www.opscode.com/chef/install.sh | bash -s -- -P chefdk

ENV LANG en_US.UTF-8
RUN locale-gen $LANG

ADD vimrc /root/.vimrc
RUN mkdir -p /home/$USER/chef-repo/cookbooks
WORKDIR /home/$USER
CMD ["/usr/sbin/sshd", "-D"]
