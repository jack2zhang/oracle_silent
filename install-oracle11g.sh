#!/bin/bash
yum install -y  gcc make binutils setarch compat-db compat-gcc-34 compat-gcc-34-c++ compat-libstdc++-33 unixODBC unixODBC-devel libaio-devel sysstat compat-gcc-34 compat-gcc-34-c++ unzip libXext
#set /etc/hosts
groupadd -g 1000 oinstall
groupadd -g 1001 dba
useradd -u 1000 -g oinstall -G dba oracle
#passwd oracle
mkdir -p /u01/oracle
chown -R oracle:oinstall /u01/
chmod -R 755 /u01/
{
cat <<'XUNLEI'
export ORACLE_BASE=/u01/oracle
export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/dbhome_1
export ORACLE_SID=vnetoodb
export PATH=$PATH:$HOME/bin:$ORACLE_HOME/bin
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
XUNLEI
} >> /home/oracle/.bash_profile
source /home/oracle/.bash_profile
{
cat <<'XUNLEI'
oracle soft nproc 2047
oracle hard nproc 16384
oracle soft nofile 1024
oracle hard nofile 65536
XUNLEI
} >> /etc/security/limits.conf
unzip linux.x64_11gR2_database_1of2.zip -d /u01/oracle/
unzip linux.x64_11gR2_database_2of2.zip -d /u01/oracle/
chown -R oracle:dba /u01/oracle
sed -i '/CV_ASSUME_DISTID/s/4/6/g' /u01/oracle/database/stage/cvu/cv/admin/cvu_config
#su - oracle
#cd /u01/oracle/database
#./runInstaller -silent -force -responseFile /home/oracle/db.rsp 
#dbca -silent -responseFile /home/oracle/dbca.rsp 
#netca -silent -responsefile /u01/oracle/database/response/netca.rsp
#cp oracle.init.d /etc/init.d/oracle
#chkconfig oracle on
