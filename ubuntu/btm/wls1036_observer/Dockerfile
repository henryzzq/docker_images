FROM zhiqzhao/ubuntu_btm_base:latest

MAINTAINER Henry Zhao (https://www.linkedin.com/in/dreamerhenry)

USER root

ENV PATH $PATH:/root/Oracle/Middleware/wlserver_10.3/common/bin:/root/Oracle/Middleware/user_projects/domains/base_domain/bin
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


WORKDIR /

#Download btm observer
RUN perl gdown.pl 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WdQXpWQ1pRMUE0Qmc' 'BTMObserver.zip'

RUN unzip BTMObserver.zip -d /root/Oracle/Middleware/wlserver_10.3

RUN rm BTMObserver.zip

RUN sed -i 's/HOST/$BTM_HOST/' /root/Oracle/Middleware/wlserver_10.3/nanoagent/bin/nanoEnvWeblogic.sh && \
    sed -i 's/PORT/$BTM_PORT/' /root/Oracle/Middleware/wlserver_10.3/nanoagent/bin/nanoEnvWeblogic.sh && \
    sed -i 's/HOST/$BTM_HOST/' /root/Oracle/Middleware/wlserver_10.3/nanoagent/bin/nanoEnvWeblogic.cmd && \
    sed -i 's/PORT/$BTM_PORT/' /root/Oracle/Middleware/wlserver_10.3/nanoagent/bin/nanoEnvWeblogic.cmd

RUN echo 'echo BTMHOST=$BTM_HOST:$BTM_PORT' >> /root/.bashrc && \
    echo 'source /root/Oracle/Middleware/user_projects/domains/base_domain/bin/setDomainEnv.sh' >> /root/.bashrc && \
    echo 'source /root/Oracle/Middleware/wlserver_10.3/nanoagent/bin/nanoEnvWeblogic.sh' >> /root/.bashrc

RUN chmod +x /root/Oracle/Middleware/user_projects/domains/base_domain/bin/*.sh

# Expose Node Manager default port, and also default http/https ports for admin console
EXPOSE 7001 5556 8453

CMD ["startWebLogic.sh"]