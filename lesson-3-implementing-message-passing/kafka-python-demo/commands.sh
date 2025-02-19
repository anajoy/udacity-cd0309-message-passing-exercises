# Install Kafka on your Linux Ubuntu 22.04.5 release (WSL2)
# Upgrade your ubuntu release
lsb_release -a
sudo apt update
sudo apt full-upgrade
# visit page: https://kafka.apache.org/quickstart
# copy downloaded source /var/tmp/kafka_2.13-3.9.0.tgz
sudo mkdir -p /opt/kafka
sudo chown phaeton:phaeton /opt/kafka
cd /opt/kafka

# check download integrity
wget https://downloads.apache.org/kafka/KEYS
gpg --import KEYS

wget https://downloads.apache.org/kafka/3.9.0/kafka_2.13-3.9.0.tgz.asc
wget https://downloads.apache.org/kafka/3.9.0/kafka_2.13-3.9.0.tgz.sha1
wget https://downloads.apache.org/kafka/3.9.0/kafka_2.13-3.9.0.tgz.sha512

gpg --verify kafka_2.13-3.9.0.tgz.asc /var/tmp/kafka_2.13-3.9.0.tgz

cd /var/tmp
gpg --print-md SHA512 kafka_2.13-3.9.0.tgz > /opt/kafka/kafka_2.13-3.9.0.tgz.sha512.computed
diff kafka_2.13-3.9.0.tgz.sha512 kafka_2.13-3.9.0.tgz.sha512.computed


# java install options on ubuntu
https://www.cherryservers.com/blog/how-to-install-java-on-ubuntu
# install openjdk java 17
sudo apt install openjdk-17-jdk

# unpack and start kafka
tar -xzf /var/tmp/kafka_2.13-3.9.0.tgz
cd kafka_2.13-3.9.0
bin/zookeeper-server-start.sh config/zookeeper.properties
bin/kafka-server-start.sh config/server.properties

# create and test topic
bin/kafka-topics.sh --create --topic items --bootstrap-server localhost:9092
'''
Created topic items.
'''

bin/kafka-console-consumer.sh --topic items --from-beginning --bootstrap-server localhost:9092
# messages will apear in this window

bin/kafka-console-producer.sh --topic items --bootstrap-server localhost:9092
'''
>Hello World!
>How are you?
>{Info: "A value"}
>
'''

## work woth kafka python library
cd /mnt/d/repo/udacity/udacity-cd0309-message-passing-exercises/lesson-3-implementing-message-passing/kafka-python-demo
workon udacity_msg_3
pip install kafka-python
pip list
python3 consumer.py
# the folling outputs appears after starting python3 producer.py
'''
ConsumerRecord(topic='items', partition=0, offset=3, timestamp=1739315778040, timestamp_type=0, key=None, value=b'Test Message!!!', headers=[], checksum=None, serialized_key_size=-1, serialized_value_size=15, serialized_header_size=-1)
'''

# open a new windiow and run
cd /mnt/d/repo/udacity/udacity-cd0309-message-passing-exercises/lesson-3-implementing-message-passing/kafka-python-demo
workon udacity_msg_3
python3 producer.py
