FROM zhiqzhao/ubuntu_btm_wls1036_domain:latest

MAINTAINER Henry Zhao (https://www.linkedin.com/in/dreamerhenry)

USER root

ENV WLSERVER_HOME /root/Oracle/Middleware/wlserver_10.3
ENV WLDOMAIN_HOME /root/Oracle/Middleware/user_projects/domains/base_domain
ENV PATH $PATH:/util

RUN mkdir -p /util

RUN echo 'echo BTMHOST=$BTM_HOST:$BTM_PORT' >> /root/.bashrc && \
    echo 'echo WLSERVER_HOME=$WLSERVER_HOME' >> /root/.bashrc && \
    echo 'echo WLDOMAIN_HOME=$WLDOMAIN_HOME' >> /root/.bashrc && \
    echo 'source $WLDOMAIN_HOME/bin/setDomainEnv.sh' >> /root/.bashrc && \
    echo 'source $WLSERVER_HOME/nanoagent/bin/nanoEnvWeblogic.sh' >> /root/.bashrc && \
    echo "echo \"**********************************************\"">> /root/.bashrc && \
    echo 'echo Usage:' >> /root/.bashrc && \
    echo "echo \"exec 'deployOB.sh' to deploy observer\"" >> /root/.bashrc && \
    echo "echo \"exec 'startWL.sh' to startup weblogic\""  >> /root/.bashrc && \
    echo "echo \"**********************************************\"">> /root/.bashrc

RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WdeHlDdDdCSFkxZWc' -O deployOB.sh

RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B-NEimEr29Wdamh5WWY2eVBVY00' -O startWL.sh

RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WdaDZRU190MmNCamM' -O main.sh

RUN mv /deployOB.sh /util && \
    mv /startWL.sh /util && \
    mv /main.sh /util && \
    chmod a+x /util/*.sh
    
# Expose Node Manager default port, and also default http/https ports for admin console
EXPOSE 7001 5556 8453 36963

CMD ["/util/main.sh"]