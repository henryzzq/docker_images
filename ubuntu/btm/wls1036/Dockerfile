FROM zhiqzhao/ubuntu_btm_base:latest

MAINTAINER Henry Zhao (https://www.linkedin.com/in/dreamerhenry)

USER root

ENV PATH $PATH:/root/Oracle/Middleware/wlserver_10.3/common/bin
ENV CONFIG_JVM_ARGS '-Djava.security.egd=file:/dev/./urandom'
ENV JAVA_OPTIONS '-Djava.security.egd=file:/dev/./urandom'
ENV JAVA_HOME $JAVA16_HOME

#Download weblogic 10.3.6
RUN perl gdown.pl 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WdbURhaE16NElXbjA' 'wls1036_generic.jar'

#Download silence mode script
RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WdS0N5a1VOYVptZEE' -O wls-silent.xml

RUN mkdir /root/Oracle && \
    chmod a+xr /root/Oracle

RUN $JAVA_HOME/bin/java -jar wls1036_generic.jar -mode=silent -silent_xml=/wls-silent.xml && \ 
	rm /wls1036_generic.jar /wls-silent.xml 
	
# Expose Node Manager default port, and also default http/https ports for admin console
EXPOSE 7001 5556 8453 36963

CMD ["bash"]