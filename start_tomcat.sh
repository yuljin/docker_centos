#/app/tomcat/bin/catalina.sh run -config /server.xml

cd /deploy

git clone https://github.com/yuljin/webservice.git web

cd /deploy/web

mvn clean compile war:war

/app/tomcat/bin/catalina.sh run -config /server-web.xml

