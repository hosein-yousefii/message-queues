FROM fedora:latest
MAINTAINER "Hosein Yousefi yousefi.hosein.o@gmail.com"
ENV container docker
RUN yum -y update; yum clean all
RUN yum -y install systemd; yum clean all;
RUN yum search java
RUN yum install -y java-17-openjdk.x86_64 which unzip openssh-server sudo openssh-clients && yum clean all
# enable no pass and speed up authentication
RUN sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords yes/;s/#UseDNS yes/UseDNS no/' /etc/ssh/sshd_config

# enabling sudo group
RUN echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers
# enabling sudo over ssh
RUN sed -i 's/.*requiretty$/#Defaults requiretty/' /etc/sudoers

ENV JAVA_HOME /usr/lib/jvm/jre

# add a user for the application, with sudo permissions
RUN useradd -m activemq ; echo activemq: | chpasswd ; usermod -a -G wheel activemq

# command line goodies
RUN echo "export JAVA_HOME=/usr/lib/jvm/jre" >> /etc/profile
RUN echo "alias ll='ls -l --color=auto'" >> /etc/profile
RUN echo "alias grep='grep --color=auto'" >> /etc/profile


WORKDIR /home/activemq

USER activemq

RUN curl  --output apache-mq.tgz https://dlcdn.apache.org//activemq/5.17.1/apache-activemq-5.17.1-bin.tar.gz
RUN tar -xf apache-mq.tgz
RUN rm apache-mq.tgz
RUN chown -R activemq:activemq apache-activemq-5.17.1

WORKDIR /home/activemq/apache-activemq-5.17.1/conf
RUN sed -i "s/<property name=\"host\" value=\"127\.0\.0\.1\"\/>/<property name=\"host\" value=\"0\.0\.0\.0\"\/>/" jetty.xml 

WORKDIR /home/activemq/apache-activemq-5.17.1/bin
RUN chmod u+x ./activemq

WORKDIR /home/activemq/apache-activemq-5.17.1/

# ensure we have a log file to tail
RUN mkdir -p data/
RUN echo >> data/activemq.log
EXPOSE 22 1099 61616 8161 5672 61613 1883 61614

WORKDIR /home/activemq/apache-activemq-5.17.1/conf
RUN rm -f startup.sh
COPY activemq-cluster-config.sh startup.sh
USER root
RUN chown activemq:activemq ./startup.sh
RUN chmod u+x ./startup.sh
USER activemq

CMD  /home/activemq/apache-activemq-5.17.1/conf/startup.sh
