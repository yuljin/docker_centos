FROM centos
MAINTAINER yuljin3@naver.com

RUN yum install wget -y
RUN yum install tar -y
RUN yum install git -y

# mkdir app directory 
RUN mkdir -p /app

WORKDIR /app

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

ENV CATALINA_HOME /app/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

# install jdk 
RUN \
wget -q http://download.nhnsystem.com/webapps/jdk/jdk-6u45-linux-x64.bin -O jdk-6u45-linux-x64.bin && \
chmod 755 jdk-6u45-linux-x64.bin && \
./jdk-6u45-linux-x64.bin -noregister > /dev/null && \
ln -s jdk1.6.0_45 jdk

ENV JAVA_HOME /app/jdk
ENV PATH ${JAVA_HOME}/bin:$PATH

# install MAVEN 
RUN \
wget http://apache.tt.co.kr/maven/maven-3/3.2.3/binaries/apache-maven-3.2.3-bin.tar.gz -O apache-maven-3.2.3-bin.tar.gz && \
tar -zxf apache-maven-3.2.3-bin.tar.gz  && \
ln -s apache-maven-3.2.3 maven 

ENV M2_HOME /app/maven
ENV PATH $M2_HOME/bin:$PATH

ADD start_tomcat.sh /start_tomcat.sh
RUN chmod +x /start_tomcat.sh

#ENTRYPOINT ["/app/tomcat/bin/catalina.sh", "run"]
CMD /start_tomcat.sh
