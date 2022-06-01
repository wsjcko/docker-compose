#!/bin/bash
# if [ $# != 3 ]; then
#     echo "missing user,passwd"
#     exit 1;
# fi


### mysql8 不支持，需要先创建用户，授权
# GRANT REPLICATION CLIENT, PROCESS ON  *.*  to 'exporter'@'%' identified by '123456';
# GRANT SELECT ON *.* TO 'exporter'@'%';
# flush privileges;

# 限制exporter用户连接数
# CREATE USER 'exporter'@'%'IDENTIFIED BY '123456' WITH MAX_USER_CONNECTIONS 3;
# GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'exporter'@'%';
# flush privileges;

PASSWORD='sjc123456' 
EXPORTER_USER='exporter' 
EXPORTER_PASSWD='123456'
echo "script-mysql_exporter"
GRANT_SQL1="GRANT REPLICATION CLIENT, PROCESS ON performance_schema.*  to '$EXPORTER_USER'@'%' identified by '$EXPORTER_PASSWD';"
GRANT_SQL2="GRANT SELECT ON performance_schema.* TO '$EXPORTER_USER'@'%';"
GRANT_SQL3="flush privileges;"
GRANT_SQL=$GRANT_SQL1$GRANT_SQL2$GRANT_SQL3
echo $GRANT_SQL
mysql -uroot -p"$PASSWORD" -e "$GRANT_SQL"
mysql -uroot -p"$PASSWORD" -s mysql <<EOF
GRANT REPLICATION CLIENT, PROCESS ON *.*  to ${EXPORTER_USER}@'%' identified by ${EXPORTER_PASSWD};
GRANT SELECT ON *.* TO $EXPORTER_USER@'%';
flush privileges;
EOF
echo "script-mysql_exporter success"
mysql --version
# tail -f /dev/null