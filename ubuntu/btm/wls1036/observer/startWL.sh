#!/bin/bash

echo '**********************************************'
echo BTMHOST=$BTM_HOST:$BTM_PORT
echo WLSERVER_HOME=$WLSERVER_HOME
echo WLDOMAIN_HOME=$WLDOMAIN_HOME
echo '**********************************************'

chmod +x $WLDOMAIN_HOME/bin/*.sh

source $WLDOMAIN_HOME/bin/setDomainEnv.sh
source $WLSERVER_HOME/nanoagent/bin/nanoEnvWeblogic.sh

$WLDOMAIN_HOME/bin/startWebLogic.sh