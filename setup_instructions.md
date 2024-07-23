# Cloudera Setup Instructions

## From Scratch
Follow the instructions [here](https://www.simplilearn.com/tutorials/big-data-tutorial/cloudera-quickstart-vm) to set up the Cloudera Quickstart VM.

## Check IP Address
To check your IP address, use the following command:
```bash
ip add
```
Example output:
```plaintext
e.g. 192.168.64.3/24
IP Address: 192.168.64.3
Subnet Mask: /24 which corresponds to 255.255.255.0
cloudera@192.168.64.3
```

## Login to Cloudera Live
```bash
sudo /home/cloudera/cloudera-manager --force --express
```

## Create Python Files
Use nano or gedit to create the mapper and reducer scripts.
```bash
nano wordcount_mapper.py
```
After editing, save the file by pressing Ctrl + O, then Enter, and then exit nano by pressing Ctrl + X. \
\
Alternatively, use gedit:
```bash
gedit wordcount_mapper.py
```

## Turn Off Safe Mode
```bash
hdfs dfsadmin -safemode leave
```
\
If superuser privilege is required:
```bash
sudo -u hdfs hdfs dfsadmin -safemode leave
```

## Make Scripts Executable
```bash
chmod +x wordcount_mapper.py
chmod +x wordcount_reducer.py
```

## Start Namenode & Datanode
```bash
sudo service hadoop-hdfs-namenode start
sudo service hadoop-hdfs-datanode start
```

## Create Data Files
```bash
echo "A long time ago in a galaxy far far away" > /home/cloudera/testfile1
echo "Another episode of Star Wars" > /home/cloudera/testfile2
```

## Create HDFS Directory
```bash
sudo -u hdfs hdfs dfs -mkdir /user/cloudera/input
```

## Upload Data to HDFS
```bash
sudo -u hdfs hdfs dfs -put /home/cloudera/testfile1 /user/cloudera/input
sudo -u hdfs hdfs dfs -put /home/cloudera/testfile2 /user/cloudera/input
```

## Verify Data in HDFS
```bash
sudo -u hdfs hdfs dfs -ls /user/cloudera/input
```

## Remove Output Directory if Error Occurs
```bash
hdfs dfs -rm -r /user/cloudera/output_new
```

## Run Hadoop Job
```bash
sudo -u hdfs hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
-input /user/cloudera/input \
-output /user/cloudera/output_new \
-mapper /home/cloudera/wordcount_mapper.py \
-reducer /home/cloudera/wordcount_reducer.py
```

## Unresolved Issues
1. Copy and paste from Mac to VM

## Questions and Reflections
1. Why use Cloudera despite its slowness? What are the advantages?
2. What changes occur when modifying the number of reducers?
