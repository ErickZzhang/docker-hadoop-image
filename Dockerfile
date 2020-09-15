FROM eric/ubuntu:base

LABEL Author="erick.zhttty@gmail.com"

WORKDIR /root

# copy resources 
COPY config/* /tmp/
COPY res/* /tmp/

# install jdk1.8.0_261, hadoop2.7.3, zookeeper3.4.14, hbase2.0.4, maven
RUN tar -xzf /tmp/jdk-8u261-linux-x64.tar.gz -C /usr/ && \
tar -xzf /tmp/hadoop-2.7.3.tar.gz -C /usr/ && \
tar -xzf /tmp/zookeeper-3.4.14.tar.gz -C /usr/ && \
tar -xzf /tmp/hbase-2.0.4-bin.tar.gz -C /usr/ && \
tar -xzf /tmp/apache-maven-3.6.3-bin.tar.gz -C /usr/

#set environment variable
ENV JAVA_HOME=/usr/jdk1.8.0_261
ENV HADOOP_HOME=/usr/hadoop-2.7.3
ENV ZOOKEEPER_HOME=/usr/zookeeper-3.4.14
ENV HBASE_HOME=/usr/hbase-2.0.4
ENV MAVEN_HOME=/usr/apache-maven-3.6.3
ENV PATH=$PATH:$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$ZOOKEEPER_HOME/bin:$HBASE_HOME/bin:$MAVEN_HOME/bin


RUN mkdir -p ~/hdfs/namenode && \
mkdir -p ~/hdfs/datanode && \
mkdir $HADOOP_HOME/logs && \

# hadoop conf
mv /tmp/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \ 
mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
mv /tmp/slaves $HADOOP_HOME/etc/hadoop/slaves && \

# enable start zookeeper in slaves from hadoop-master
mv /tmp/zkEnv.sh $ZOOKEEPER_HOME/bin && \

mv /tmp/start-hadoop.sh ~/start-hadoop.sh && \
mv /tmp/run-wordcount.sh ~/run-wordcount.sh && \
mv /tmp/start-zookeeper-all.sh ~/start-zookeeper-all.sh && \

# zookeeper conf
mv /tmp/zoo.cfg $ZOOKEEPER_HOME/conf && \
rm $ZOOKEEPER_HOME/conf/zoo_sample.cfg && \
mkdir -p ~/zookeeper/zookeeper_data && \
echo 1 > ~/zookeeper/zookeeper_data/myid && \

# hbase conf
mv /tmp/hbase-env.sh $HBASE_HOME/conf/hbase-env.sh && \
mv /tmp/hbase-site.xml $HBASE_HOME/conf/hbase-site.xml && \
mv /tmp/regionservers $HBASE_HOME/conf/regionservers && \


rm -rf /tmp/* && \
rm -rf $HBASE_HOME/docs && \

chmod +x ~/start-hadoop.sh && \
chmod +x ~/run-wordcount.sh && \
chmod +x ~/start-zookeeper-all.sh && \
chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
chmod +x $HADOOP_HOME/sbin/start-yarn.sh

RUN $HADOOP_HOME/bin/hdfs namenode -format

CMD [ "sh", "-c", "service ssh start; bash"]



