
# Kafka setup and start: Check ops in file commmands.sh in lesson-3-*

cd /opt/kfka/kafka_2.13-3.9.0
bin/zookeeper-server-start.sh config/zookeeper.properties
bin/kafka-server-start.sh config/server.properties

# create and test topic
bin/kafka-topics.sh --create --topic computers --bootstrap-server localhost:9092
'''
Created topic computers.
'''

bin/kafka-console-consumer.sh --topic computers --from-beginning --bootstrap-server localhost:9092
# messages will apear in this window


## work with kafka python library (new wsl2 shell)
cd /mnt/d/repo/udacity/udacity-cd0309-message-passing-exercises/lesson-4-message-passing-in-production/flask-kafka-starter
workon udacity_msg_3
## skip, if already installed
# pip install kafka-python
# pip list


flask run

# open Postman and check for data: https://web.postman.co/workspace/My-Workspace~c2add070-5134-43bf-89cb-57f7f1b886ea/overview
GET localhost:5000/api/orders/computers
'''
[
    {
        "created_at": "2020-10-16T10:31:10.969696",
        "created_by": "USER14",
        "equipment": [
            "KEYBOARD",
            "MOUSE"
        ],
        "id": "1",
        "status": "Queued"
    },
    {
        "created_at": "2020-10-16T10:29:10.969696",
        "created_by": "USER15",
        "equipment": [
            "KEYBOARD",
            "WEBCAM"
        ],
        "id": "2",
        "status": "Queued"
    }
]
'''

# Test the sendign to the queue by using Postman (see postman_testing.sh)

# Inside the python app you will see the following output:

'''
127.0.0.1 - - [19/Feb/2025 20:14:21] "GET /api/orders/computers HTTP/1.1" 200 -
127.0.0.1 - - [19/Feb/2025 20:16:02] "POST /api/orders/computers HTTP/1.1" 202 -
'''
