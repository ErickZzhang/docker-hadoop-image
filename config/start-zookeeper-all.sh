zkServer.sh start
ssh hadoop-slave1 "/usr/zookeeper-3.4.14/bin/zkServer.sh start"
ssh hadoop-slave2 "/usr/zookeeper-3.4.14/bin/zkServer.sh start"

echo -e "all start\n"
echo -e "hadoop-master status\n"
zkServer.sh status
