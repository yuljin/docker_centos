#/app/tomcat/bin/catalina.sh run -config /server.xml

cd /deploy

git clone http://github.nhnent.com/operation-service/hgv-web.git hgv

cd /deploy/hgv

mvn clean compile war:exploded -P alpha
