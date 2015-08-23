FROM ubuntu:precise
MAINTAINER João Pedro < pedro.joao@gmail.com>
# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list && \
  apt-get update && apt-get -y install python-software-properties && \
  add-apt-repository ppa:webupd8team/java && \
  apt-get update && apt-get -y upgrade && \
  echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
  apt-get -y install oracle-java7-installer && apt-get clean && \
  update-alternatives --display java && \
  echo "JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> /etc/environment && \
  apt-get -y install unzip && \
  apt-get -y install subversion && \
  wget http://download01.thoughtworks.com/go/13.4.1/ga/go-server-13.4.1-18342.deb && \
  wget http://download01.thoughtworks.com/go/13.4.1/ga/go-agent-13.4.1-18342.deb && \
  dpkg -i go-server-*.deb && \
  dpkg -i go-agent-*.deb && \

EXPOSE 8153

RUN mkdir /opt/bin && \
  echo "/etc/init.d/go-server start" > /opt/bin/start_go.sh && \
  echo "/etc/init.d/go-server start" >> /opt/bin/start_go.sh && \
  chmod +x /opt/bin/start_go.sh

CMD /etc/init.d/go-server start && /etc/init.d/go-agent start && tail -f /var/log/syslog
