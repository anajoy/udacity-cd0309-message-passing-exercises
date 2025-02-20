#!/bin/bash

# test for POST request by postman
# open postman in browser in browser when signed in with your google account
# https://web.postman.co/


# GET request
localhost:5000/api/orders/computers

# Returns the following output in json as respone
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



# POST request


# Paste json text to tab body using option raw JSON and press "Beautify" and get it nicely formatted.
# {"created_at": "2025-02-19T19:51:00.000000", "created_by": "USER16","equipment": ["KEYBOARD", "MOUSE"], "id": "3", "status": "Queued"}

# Inside the topic queue in kafka we see the following message:
'''
phaeton@SCHNABEL:/opt/kafka/kafka_2.13-3.9.0 $ bin/kafka-console-consumer.sh --topic computers --from-beginning --bootstrap-server localhost:9092
{"created_at": "2025-02-19T19:51:00.000000", "created_by": "USER16", "equipment": ["KEYBOARD", "MOUSE"], "id": "3", "status": "Queued"}
'''

# Application will return html status code "202 ACCEPTED"
