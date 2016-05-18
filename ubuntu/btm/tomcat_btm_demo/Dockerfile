FROM zhiqzhao/ubuntu_btm_base:latest

MAINTAINER Henry Zhao (https://www.linkedin.com/in/dreamerhenry)

USER root

#default to use jdk 1.6
ENV JAVA_HOME $JAVA16_HOME

#Download tomcat+btm
RUN perl gdown.pl 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WdS0ZXN2NlNlFhTHM' 'apache-tomcat-5.5.31.zip'

RUN unzip apache-tomcat-5.5.31.zip -d /root/

RUN rm apache-tomcat-5.5.31.zip && \
    chmod +x /root/apache-tomcat-5.5.31/bin/*.sh

RUN sed -i 's/JAVA_HOME=/JAVA_HOME=$JAVA_HOME/' /root/apache-tomcat-5.5.31/bin/startup.sh && \
    sed -i 's/$CATALINA_HOME\/jre/$JAVA_HOME\/jre/' /root/apache-tomcat-5.5.31/bin/startup.sh

# Expose Node Manager default port, and also default http/https ports for admin console
EXPOSE 8080

CMD ["/root/apache-tomcat-5.5.31/bin/startup.sh"]