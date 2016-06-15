#!/bin/bash

if [ -n "$DB_HOST" ]; then
    echo DBHOST=$DB_HOST:$DB_PORT
    if [[ "$DB_TYPE" = "oracle" && -f /oralce_wlsbjmsrpDataSource-jdbc.xml ]]; then
        sed -i "s/dbhost/$DB_HOST/" /oralce_wlsbjmsrpDataSource-jdbc.xml
        sed -i "s/dbport/$DB_PORT/" /oralce_wlsbjmsrpDataSource-jdbc.xml
    	mv /oralce_wlsbjmsrpDataSource-jdbc.xml /root/Oracle/Middleware/user_projects/domains/osb_domain/config/jdbc/wlsbjmsrpDataSource-jdbc.xml
    fi
fi

/root/Oracle/Middleware/user_projects/domains/osb_domain/bin/startWebLogic.sh