#!/bin/bash

# the default node number is 3
N=${1:-3}


# start hadoop master container
docker rm -f hadoop-master &> /dev/null
echo "start hadoop-master container..."
docker run -itd \
                --net=hadoop \
                -p 9870:50070 \
                -p 8088:8088 \
	-p 16010:16010 \
                -p 16000:16000 \
                --name hadoop-master \
                --hostname hadoop-master \
                eric/hadoop:1.0 &> /dev/null



# start hadoop slave container
i=1
while [ $i -lt $N ]
do
	docker rm -f hadoop-slave$i &> /dev/null
	echo "start hadoop-slave$i container..."
	docker run -itd \
	                --net=hadoop \
	                --name hadoop-slave$i \
	                --hostname hadoop-slave$i \
	                eric/hadoop:1.0 &> /dev/null
	i=$(( $i + 1 ))
done 

winpty docker exec -it hadoop-slave1 bash -c "echo 2 > /root/zookeeper/zookeeper_data/myid"
winpty docker exec -it hadoop-slave2 bash -c "echo 3 > /root/zookeeper/zookeeper_data/myid"

# get into hadoop master container
winpty docker exec -it hadoop-master bash
