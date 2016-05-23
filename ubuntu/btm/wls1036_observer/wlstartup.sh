#!/bin/bash

echo '**********************************************'
echo BTMHOST=$BTM_HOST:$BTM_PORT
echo '**********************************************'

source /root/Oracle/Middleware/user_projects/domains/base_domain/bin/setDomainEnv.sh
source /root/Oracle/Middleware/wlserver_10.3/nanoagent/bin/nanoEnvWeblogic.sh

/root/Oracle/Middleware/user_projects/domains/base_domain/bin/startWebLogic.sh