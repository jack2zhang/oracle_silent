#!/bin/sh
# chkconfig: 345 61 61
# description: Oracle 11g AutoRun Services
# /etc/init.d/oracle
#
# Run-level Startup script for the Oracle Instance, Listener, and
# Web Interface

export ORACLE_BASE=/u01/oracle
export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/dbhome_1
export ORACLE_SID=vnetoodb
export PATH=$PATH:$ORACLE_HOME/bin
ORA_OWNR="oracle"

# if the executables do not exist -- display error

if [ ! -f $ORACLE_HOME/bin/dbstart -o ! -d $ORACLE_HOME ]
then
     echo "Oracle startup: cannot start"
     exit 1
fi

# depending on parameter -- startup, shutdown, restart
# of the instance and listener or usage display

case "$1" in
 start)
     # Oracle listener and instance startup
     #su $ORA_OWNR -lc $ORACLE_HOME/bin/lsnrctl start
     su $ORA_OWNR -lc "$ORACLE_HOME/bin/dbstart $ORACLE_HOME"
     echo "Oracle Start Succesful!OK."
     ;;
 stop)
     # Oracle listener and instance shutdown
     #su $ORA_OWNR -lc $ORACLE_HOME/bin/lsnrctl stop
     su $ORA_OWNR -lc "$ORACLE_HOME/bin/dbshut $ORACLE_HOME"
     echo "Oracle Stop Succesful!OK."
     ;;
 reload|restart)
     $0 stop
     $0 start
     ;;
 *)
     echo $"Usage: `basename $0` {start|stop|reload|reload}"
     exit 1
esac
exit 0

