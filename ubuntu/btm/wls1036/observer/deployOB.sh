#!/bin/bash

echo 'Deploying nanoagent under '$WLSERVER_HOME

rm -rf $WLSERVER_HOME/nanoagent

unzip /observer/BTMObserver.zip -d $WLSERVER_HOME > /dev/null

sed -i 's/HOST/$BTM_HOST/' $WLSERVER_HOME/nanoagent/bin/nanoEnvWeblogic.sh
sed -i 's/PORT/$BTM_PORT/' $WLSERVER_HOME/nanoagent/bin/nanoEnvWeblogic.sh
sed -i 's/HOST/$BTM_HOST/' $WLSERVER_HOME/nanoagent/bin/nanoEnvWeblogic.cmd
sed -i 's/PORT/$BTM_PORT/' $WLSERVER_HOME/nanoagent/bin/nanoEnvWeblogic.cmd

chmod +x $WLSERVER_HOME/nanoagent/bin/*.sh

echo 'Deploying nanoagent is done.'