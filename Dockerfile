FROM ubuntu:trusty

MAINTAINER SungKwang Song <saltfactory@gmail.com>
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm
ENV TIMEZONE Asia/Seoul

# timezone
RUN echo $TIMEZONE > /etc/timezone && dpkg-reconfigure tzdata

# chefdk
RUN apt-get update
RUN apt-get install curl vim -y
RUN curl -L https://www.opscode.com/chef/install.sh | bash -s -- -P chefdk

#https://github.com/berkshelf/berkshelf-api/issues/112#issuecomment-44171378
ENV LANG en_US.UTF-8
RUN locale-gen $LANG

ADD vimrc /root/.vimrc

RUN mkdir /var/data
WORKDIR /var/data
CMD ["bash"]
