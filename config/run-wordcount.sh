#!bin/bash

# create input files
mkdir input
echo "Hello Docker" > input/file1.txt
echo "Hello Hadoop" > input/file2.txt

# create input dir on HDFS
hadoop fs -mkdir -p input

# put input files to HDFS
hdfs dfs -put ./input/* input

# run wordcount
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/sources/hadoop-mapreduce-examples-2.7.3-sources.jar org.apache.hadoop.examples.WordCount input output

# print the input files
echo -e "\ninput file1.txt"
hdfs dfs -cat input/file1.txt
echo -e "\ninput file2.txt"
hdfs dfs -cat input/file2.txt

# print the output of wordcount
echo -e "\nwordcount output:"
hdfs dfs -cat output/part-r-00000
