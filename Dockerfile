FROM tomcat:9.0.37-jdk8
ADD ./target/addressbook-1.0.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD "catalina.sh"  "run"





# docker stop fusisoft-webapps;docker rm fusisoft-webapps;docker rmi fusisoft-webapps:1.1.0
# rm -rf docker-jenkins-build
# mkdir docker-jenkins-build
# cd docker-jenkins-build
# cp /var/lib/jenkins/workspace/fusisoft-maven-project/target/myapps.war .
# touch dockerfile
# cat <<EOT>>dockerfile
# FROM tomcat:9.0.37-jdk8
# ADD myapps.war /usr/local/tomcat/webapps/
# EXPOSE 8080
# CMD "catalina.sh"  "run"
# EOT
# docker build -t fusisoft-webapps:1.1.0 .
# docker run -itd --name=fusisoft-webapps -p 8085:8080 fusisoft-webapps:1.1.0