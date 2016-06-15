#!/bin/bash

echo '**********************************************'
echo BTMHOST=$BTM_HOST:$BTM_PORT
echo DBHOST=$DB_HOST:$DB_PORT
echo WLSERVER_HOME=$WLSERVER_HOME
echo WLDOMAIN_HOME=$WLDOMAIN_HOME
echo '**********************************************'

echo "Starting Administration Server..."

chmod +x $WLDOMAIN_HOME/bin/*.sh
source $WLDOMAIN_HOME/bin/setDomainEnv.sh
source $WLSERVER_HOME/nanoagent/bin/nanoEnvWeblogic.sh

if [ -n "$DB_HOST" ]; then
    echo DB_HOST=$DB_HOST:$DB_PORT
    if [[ "$DB_TYPE" = "oracle" && -f /oralce_wlsbjmsrpDataSource-jdbc.xml ]]; then
        sed -i "s/dbhost/$DB_HOST/" /oralce_wlsbjmsrpDataSource-jdbc.xml
        sed -i "s/dbport/$DB_PORT/" /oralce_wlsbjmsrpDataSource-jdbc.xml
    	mv /oralce_wlsbjmsrpDataSource-jdbc.xml $WLDOMAIN_HOME/config/jdbc/wlsbjmsrpDataSource-jdbc.xml
    fi
fi

rm -f $WLDOMAIN_HOME/admin_server.log
touch  $WLDOMAIN_HOME/admin_server.log

$WLDOMAIN_HOME/bin/startWebLogic.sh > $WLDOMAIN_HOME/admin_server.log &
echo "Logging Administration Server in ${WLDOMAIN_HOME}/admin_server.log..."

tail -f $WLDOMAIN_HOME/admin_server.log | while read LINE
do
    if [[ "${LINE}" == *"Server started in RUNNING mode"* ]];
    then
       echo "Administration Server started."
       pkill -P $$ tail
    fi
done

echo '**********************************************'

$WLDOMAIN_HOME/bin/startManagedWebLogic.sh "osb_server1" "http://localhost:7001"