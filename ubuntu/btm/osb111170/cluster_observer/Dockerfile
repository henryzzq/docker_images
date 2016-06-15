FROM zhiqzhao/ubuntu_btm_osb111170_cluster:latest

MAINTAINER Henry Zhao (https://www.linkedin.com/in/dreamerhenry)

USER root

ENV WLSERVER_HOME /root/Oracle/Middleware/wlserver_10.3
ENV WLDOMAIN_HOME /root/Oracle/Middleware/user_projects/domains/osb_domain
ENV PATH $PATH:/util
ENV BTM_PORT 8080

RUN mkdir -p /util

RUN echo 'echo BTMHOST=$BTM_HOST:$BTM_PORT' >> /root/.bashrc && \
    echo 'echo DBHOST=$DB_HOST:$DB_PORT' >> /root/.bashrc && \
    echo 'echo WLSERVER_HOME=$WLSERVER_HOME' >> /root/.bashrc && \
    echo 'echo WLDOMAIN_HOME=$WLDOMAIN_HOME' >> /root/.bashrc && \
    echo 'source $WLDOMAIN_HOME/bin/setDomainEnv.sh' >> /root/.bashrc && \
    echo 'source $WLSERVER_HOME/nanoagent/bin/nanoEnvWeblogic.sh' >> /root/.bashrc && \
    echo "echo \"**********************************************\"">> /root/.bashrc && \
    echo 'echo Usage:' >> /root/.bashrc && \
    echo "echo \"exec 'deployOB.sh' to deploy observer\"" >> /root/.bashrc && \
    echo "echo \"**********************************************\"">> /root/.bashrc

RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WdeHlDdDdCSFkxZWc' -O deployOB.sh

RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WdQkFyc1FpelVJVFE' -O startWL_COSB.sh

RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WdNFRxYW1JNGR4M2c' -O main_cluster_osb.sh

RUN mv /deployOB.sh /util && \
    mv /startWL_COSB.sh /util && \
    mv /main_cluster_osb.sh /util && \
    chmod a+x /util/*.sh
    
# Expose Node Manager default port, and also default http/https ports for admin console
EXPOSE 7001 8001 8002 8101 5556 8453 36963

CMD ["/util/main_cluster_osb.sh"]