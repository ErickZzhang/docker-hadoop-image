# docker-hadoop-image
`Windows环境下手动构建大数据分布式环境的docker镜像，可自行修改配置文件、端口映射等信息`
<br/>
`目前包括Hadoop,Zookeeper,Hbase     待更新Hive、Spark、配置说明...`
<br/>
**warning: 因Windows与Linux系统中换行符表示方法不同，conf中的配置文件(除.xml外)请勿在Windows环境下编辑！！！**
# 执行步骤
## step0
`更新ubuntu基础配置，安装vim、openssh-server,此步需联网运行`
<br/>
`git bash ---> cd ./step0-buildUbuntuBase`
```
./build_image.sh
```
## step1
`安装jdk1.8, hadoop2.7.3, zookeeper3.4.14, hbase2.0.4`
<br/>
自行下载安装文件
&emsp;jdk-8u261-linux-x64.tar.gz
&emsp;hadoop-2.7.3.tar.gz
&emsp;zookeeper-3.4.14.tar.gz
&emsp;hbase-2.0.4-bin.tar.gz&emsp;至/res文件夹中
## step2
`git bash ---> cd ./`
<br/>
`构建分布式主机的镜像`
```
./build_image.sh
```
`启动三个容器`
```
./start-container.sh
```
