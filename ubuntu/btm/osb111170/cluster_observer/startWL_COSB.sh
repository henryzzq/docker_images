#!/bin/bash

echo '**********************************************'
echo BTMHOST=$BTM_HOST:$BTM_PORT
echo DBHOST=$DB_HOST:$DB_PORT
echo WLSERVER_HOME=$WLSERVER_HOME
echo WLDOMAIN_HOME=$WLDOMAIN_HOME
echo '**********************************************'

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

echo "Starting Administration Server..."
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

echo "Starting OsbServer1 Server..."
rm -f $WLDOMAIN_HOME/OsbServer1.log
touch  $WLDOMAIN_HOME/OsbServer1.log

$WLDOMAIN_HOME/bin/startManagedWebLogic.sh "OsbServer1" "http://localhost:7001" > $WLDOMAIN_HOME/OsbServer1.log &
echo "Logging OsbServer1 Server in ${WLDOMAIN_HOME}/OsbServer1.log..."

tail -f $WLDOMAIN_HOME/OsbServer1.log | while read LINE
do
    if [[ "${LINE}" == *"Server started in RUNNING mode"* ]];
    then
       echo "OsbServer1 Server started."
       pkill -P $$ tail
    fi
done

echo '**********************************************'

echo "Starting OsbServer2 Server..."
rm -f $WLDOMAIN_HOME/OsbServer2.log
touch  $WLDOMAIN_HOME/OsbServer2.log

$WLDOMAIN_HOME/bin/startManagedWebLogic.sh "OsbServer2" "http://localhost:7001" > $WLDOMAIN_HOME/OsbServer2.log &
echo "Logging OsbServer2 Server in ${WLDOMAIN_HOME}/OsbServer2.log..."

tail -f $WLDOMAIN_HOME/OsbServer2.log | while read LINE
do
    if [[ "${LINE}" == *"Server started in RUNNING mode"* ]];
    then
       echo "OsbServer2 Server started."
       pkill -P $$ tail
    fi
done

echo '**********************************************'

echo "Starting ProxyServer Server..."
rm -f $WLDOMAIN_HOME/ProxyServer.log
touch  $WLDOMAIN_HOME/ProxyServer.log

$WLDOMAIN_HOME/bin/startManagedWebLogic.sh "ProxyServer" "http://localhost:7001" > $WLDOMAIN_HOME/ProxyServer.log &
echo "Logging ProxyServer Server in ${WLDOMAIN_HOME}/ProxyServer.log..."

tail -f $WLDOMAIN_HOME/ProxyServer.log | while read LINE
do
    if [[ "${LINE}" == *"Server started in RUNNING mode"* ]];
    then
       echo "ProxyServer Server started."
       pkill -P $$ tail
    fi
done

echo '**********************************************'

/bin/bash