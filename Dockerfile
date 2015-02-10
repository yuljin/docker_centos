FROM centos
MAINTAINER yuljin3@naver.com

RUN yum install wget -y
RUN yum install tar -y
RUN yum install git -y

# mkdir app directory 
#RUN mkdir -p /app

# mkdir deploy directory
RUN mkdir -p /deploy

RUN mkdir -p /home1/

WORKDIR /home1

RUN mkdir -p /irteam

WORKDIR /home1/irteam

RUN mkdir -p /apps

#WORKDIR /app
WORKDIR /home1/irteam/apps

# install apache
RUN \
  wget http://download.nhnsystem.com/webapps/apache/apache-c6-x64.tar.gz -O apache-c6-x64.tar.gz && \
  tar -zxf apache-c6-x64.tar.gz	&& \
  ln -s apache-2.2.21 apache

# install tomcat
RUN \
  wget http://mirror.apache-kr.org/tomcat/tomcat-6/v6.0.43/bin/apache-tomcat-6.0.43.tar.gz -O tomcat.tar.gz && \
  tar -zxf tomcat.tar.gz && \
  ln -s apache-tomcat-6.0.43 tomcat

ENV CATALINA_HOME /home1/irteam/apps/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

# install jdk 
RUN \
wget -q http://download.nhnsystem.com/webapps/jdk/jdk-6u45-linux-x64.bin -O jdk-6u45-linux-x64.bin && \
chmod 755 jdk-6u45-linux-x64.bin && \
./jdk-6u45-linux-x64.bin -noregister > /dev/null && \
ln -s jdk1.6.0_45 jdk

#ENV JAVA_HOME /app/jdk
ENV JAVA_HOME /home1/irteam/apps/jdk
ENV PATH ${JAVA_HOME}/bin:$PATH

# install MAVEN 
RUN \
wget http://apache.tt.co.kr/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz -O apache-maven-3.2.5-bin.tar.gz && \
tar -zxf apache-maven-3.2.5-bin.tar.gz  && \
ln -s apache-maven-3.2.5 maven 

#ENV M2_HOME /app/maven
#ENV PATH $M2_HOME/bin:$PATH

ENV M2_HOME /home1/irteam/apps/maven
ENV PATH $M2_HOME/bin:$PATH

# ADD start_tomcat.sh /start_tomcat.sh
#RUN chmod +x /start_tomcat.sh

#ADD server-web.xml /server-web.xml
#RUN chmod +x /server-web.xml

ADD deploy.sh /deploy.sh
RUN chmod +x /deploy.sh
RUN echo $(date) && source /deploy.sh

EXPOSE 80

#ENTRYPOINT ["/app/tomcat/bin/catalina.sh", "run"]
#ENTRYPOINT /start_tomcat.sh

#ENTRYPOINT /bin/bash
