FROM zhiqzhao/ubuntu_btm_base:latest

MAINTAINER Henry Zhao (https://www.linkedin.com/in/dreamerhenry)

USER root

ENV PATH $PATH:/root/Oracle/Middleware/oracle_common/common/bin
ENV CONFIG_JVM_ARGS '-Djava.security.egd=file:/dev/./urandom'

#Download weblogic 10.3.6
RUN perl gdown.pl 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WdbURhaE16NElXbjA' 'wls1036_generic.jar'

#Download silence mode script
RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WdRXNoMndCMUllMGs' -O wls-silent.xml

RUN mkdir /root/Oracle && \
    chmod a+xr /root/Oracle

RUN /root/jdk/jdk1.6.0_45/bin/java -jar wls1036_generic.jar -mode=silent -silent_xml=/wls-silent.xml && \ 
	rm /wls1036_generic.jar /wls-silent.xml 

#Download create domain script
RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WdQThnYjVnRmUwd2c' -O create-wls-domain.py

RUN mv create-wls-domain.py /root/Oracle && \
    chmod +x /root/Oracle/create-wls-domain.py

WORKDIR /root/Oracle/Middleware

RUN /root/Oracle/Middleware/wlserver_10.3/common/bin/wlst.sh -skipWLSModuleScanning /root/Oracle/create-wls-domain.py

# Expose Node Manager default port, and also default http/https ports for admin console
EXPOSE 7001 5556 8453

CMD ["bash"]