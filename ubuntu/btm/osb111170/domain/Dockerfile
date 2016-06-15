FROM zhiqzhao/ubuntu_btm_osb111170:latest

MAINTAINER Henry Zhao (https://www.linkedin.com/in/dreamerhenry)

USER root

ENV PATH $PATH:/root/Oracle/Middleware/user_projects/domains/osb_domain/bin
ENV DB_TYPE oracle
ENV DB_PORT 1521

#Download create domain script
RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WdS09qbHFYZFRub2M' -O create-osb-domain.py

RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WdY0RpeGw3MHF3N1k' -O startWL_DB.sh

RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WdQjk0UG0yV0o2UmM' -O oralce_wlsbjmsrpDataSource-jdbc.xml

RUN chmod -R a+x /startWL_DB.sh /create-osb-domain.py /root/Oracle/Middleware/Oracle_OSB1/common/bin

RUN mkdir -p /util && \
    mv /startWL_DB.sh /util

RUN /root/Oracle/Middleware/Oracle_OSB1/common/bin/wlst.sh -skipWLSModuleScanning /create-osb-domain.py

RUN sed -i "s/WLS_USER=\"\"/WLS_USER=\"weblogic\"/" /root/Oracle/Middleware/user_projects/domains/osb_domain/bin/startManagedWebLogic.sh && \
    sed -i "s/WLS_PW=\"\"/WLS_PW=\"Oracle@123\"/" /root/Oracle/Middleware/user_projects/domains/osb_domain/bin/startManagedWebLogic.sh

# Expose Node Manager default port, and also default http/https ports for admin console
EXPOSE 7001 8001 5556 8453 36963

CMD ["/util/startWL_DB.sh"]