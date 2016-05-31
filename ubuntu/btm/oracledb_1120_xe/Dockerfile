FROM zhiqzhao/ubuntu_btm_base:latest

MAINTAINER Henry Zhao (https://www.linkedin.com/in/dreamerhenry)

USER root

ENV ORACLE_HOME /u01/app/oracle/product/11.2.0/xe
ENV PATH $ORACLE_HOME/bin:$PATH
ENV ORACLE_SID XE
ENV ORACLE_ALLOW_REMOTE true

#Download oracle xe
RUN perl gdown.pl 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WdYnBHcWlxTXZMMjA' 'oracle-xe_11.2.0-1.0_amd64.deb'

#Download chkconfig
RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WdRlF5RVpKdXdCSTg' -O chkconfig

#Download init.ora
RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WdaEdBVlZ1ZGdLZWc' -O init.ora

#Download initXETemp.ora
RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WdcFVoTXcyZGRiODQ' -O initXETemp.ora

#Download startup.sh
RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WddWIxdTJVWnJ0M3M' -O startup.sh

RUN apt-get install -y libaio1 net-tools bc && \
    ln -s /usr/bin/awk /bin/awk && \
    mkdir /var/lock/subsys && \
    mv /chkconfig /sbin/chkconfig && \
    chmod 755 /sbin/chkconfig

# Install Oracle
RUN dpkg --install /oracle-xe_11.2.0-1.0_amd64.deb 

# Backup listener.ora as template
RUN cp /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora.tmpl

RUN mv /init.ora /u01/app/oracle/product/11.2.0/xe/config/scripts && \
    mv /initXETemp.ora /u01/app/oracle/product/11.2.0/xe/config/scripts

# Config database, password is oracle
RUN printf 8080\\n1521\\noracle\\noracle\\ny\\n | /etc/init.d/oracle-xe configure

RUN echo 'export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe' >> /etc/bash.bashrc && \
    echo 'export PATH=$ORACLE_HOME/bin:$PATH' >> /etc/bash.bashrc && \
    echo 'export ORACLE_SID=XE' >> /etc/bash.bashrc && \
    echo 'export ORACLE_ALLOW_REMOTE=true' >> /etc/bash.bashrc
    
RUN mv /startup.sh /usr/sbin/startup.sh && \
    chmod +x /usr/sbin/startup.sh && \
    rm /oracle-xe_11.2.0-1.0_amd64.deb
    
# Expose ports
EXPOSE 8080 1521

CMD ["/usr/sbin/startup.sh"]