FROM zhiqzhao/ubuntu_btm_wls1036:latest

MAINTAINER Henry Zhao (https://www.linkedin.com/in/dreamerhenry)

USER root

#Create user oracle and group oinstall
RUN groupadd oinstall && \
    echo -e "Oracle@123\nOracle@123\nOracle\n\n\n\n\n\n" | adduser oracle && \
    usermod -a -G oinstall oracle

#Download osb 11.1.1.7.0
RUN perl gdown.pl 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WdVnA3TGd5bFFWWWc' 'ofm_osb_generic_11.1.1.7.0_disk1_1of1.zip'

#Download response file
RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WdYnY1aHBuWGoxZTg' -O custom_installtype_osb11.1.1.7.rsp

RUN unzip ofm_osb_generic_11.1.1.7.0_disk1_1of1.zip

RUN /Disk1/stage/Response/createCentralInventory.sh /root/Oracle/oraInventory oinstall && \
    chmod -R a+rwx /root

RUN apt-get install -y rpm && \
    ln -s /usr/bin/rpm /bin/rpm
	
USER oracle

WORKDIR /

RUN /Disk1/runInstaller -ignoreSysPrereqs -silent -responseFile /custom_installtype_osb11.1.1.7.rsp -jreLoc $JAVA16_HOME/jre

# Expose Node Manager default port, and also default http/https ports for admin console
EXPOSE 7001 5556 8453 36963

CMD ["bash"]