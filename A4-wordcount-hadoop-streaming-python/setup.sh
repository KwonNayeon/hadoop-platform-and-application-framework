
#### `setup.sh`
```bash
#!/bin/bash

# Check IP Address
ip add

# Login to Cloudera Live
sudo /home/cloudera/cloudera-manager --force --express

# Turn Off Safe Mode
hdfs dfsadmin -safemode leave
sudo -u hdfs hdfs dfsadmin -safemode leave

# Make Scripts Executable
chmod +x wordcount_mapper.py
chmod +x wordcount_reducer.py

# Check and Leave Safe Mode with Superuser Privileges
sudo -u hdfs hdfs dfsadmin -safemode get
sudo -u hdfs hdfs dfsadmin -safemode leave
sudo -u hdfs hdfs dfsadmin -safemode get

# Start Namenode & Datanode
sudo service hadoop-hdfs-namenode start
sudo service hadoop-hdfs-datanode start

# Create Data Files
echo "A long time ago in a galaxy far far away" > /home/cloudera/testfile1
echo "Another episode of Star Wars" > /home/cloudera/testfile2

# Create HDFS Directory
sudo -u hdfs hdfs dfs -mkdir /user/cloudera/input

# Upload Data to HDFS
sudo -u hdfs hdfs dfs -put /home/cloudera/testfile1 /user/cloudera/input
sudo -u hdfs hdfs dfs -put /home/cloudera/testfile2 /user/cloudera/input

# Verify Data in HDFS
sudo -u hdfs hdfs dfs -ls /user/cloudera/input

# Remove Output Directory if Error Occurs
hdfs dfs -rm -r /user/cloudera/output_new

# Run Hadoop Job
sudo -u hdfs hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
-input /user/cloudera/input \
-output /user/cloudera/output_new \
-mapper /home/cloudera/wordcount_mapper.py \
-reducer /home/cloudera/wordcount_reducer.py
