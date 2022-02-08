#!/bin/bash
wget -nc http://localhost:8080/jnlpJars/jenkins-cli.jar &&\
init_pswd=`sudo cat /var/lib/jenkins/secrets/initialAdminPassword` &&\
echo "jenkins.model.Jenkins.instance.securityRealm.createAccount(\"$1\", \"$2\")" | java -jar jenkins-cli.jar -auth admin:$init_pswd -s http://localhost:8080/ groovy = &&\
java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080/ install-plugin git ChuckNorris -restart
