FROM zhiqzhao/ubuntu_weblogic1036_domain:latest

MAINTAINER Henry Zhao (https://www.linkedin.com/in/dreamerhenry)

USER root

#Download observer
RUN perl gdown.pl 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WdbURhaE16NElXbjA' 'BTMObs.zip'

#Download script
RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WdRXNoMndCMUllMGs' -O wls-silent.xml

RUN chmod +x /root/Oracle

RUN /root/jdk/jdk1.6.0_45/bin/java -jar wls1036_generic.jar -mode=silent -silent_xml=/wls-silent.xml && \ 
	rm /wls1036_generic.jar /wls-silent.xml 

ENV PATH $PATH:/root/Oracle/Middleware/oracle_common/common/bin

CMD ["bash"]