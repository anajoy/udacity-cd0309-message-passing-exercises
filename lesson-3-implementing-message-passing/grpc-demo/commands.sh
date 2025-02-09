cd /mnt/d/repo/udacity/udacity-cd0309-message-passing-exercises/lesson-3-implementing-message-passing/grpc-demo
workon udacity_msg_3
pip install grpcio-tools grpcio
python3 -m grpc_tools.protoc -I./ --python_out=./ --grpc_python_out=./ item.proto
python3 main.py

'''
(udacity_msg_3) phaeton@SCHNABEL:/mnt/d/repo/udacity/udacity-cd0309-message-passing-exercises/lesson-3-implementing-message-passing/grpc-demo (master)$ python3 main.py
Server starting on port 5005...
'''
# open a new console window
cd /mnt/d/repo/udacity/udacity-cd0309-message-passing-exercises/lesson-3-implementing-message-passing/grpc-demo
workon udacity_msg_3
python3 writer.py

'''
(udacity_msg_3) phaeton@SCHNABEL:/mnt/d/repo/udacity/udacity-cd0309-message-passing-exercises/lesson-3-implementing-message-passing/grpc-demo (master)$ python3 writer.py
Sending sample payload...
Traceback (most recent call last):
  File "/mnt/d/repo/udacity/udacity-cd0309-message-passing-exercises/lesson-3-implementing-message-passing/grpc-demo/writer.py", line 15, in <module>
    item = item_pb2.ItemMessage(
TypeError: bad argument type for built-in operation
'''

# check the writer.py file for the value of type string defind for field brand_name
# change it to a string value, for example: brand_name="Rêve du Chef"
python3 writer.py

# client response:
'''
(udacity_msg_3) phaeton@SCHNABEL:/mnt/d/repo/udacity/udacity-cd0309-message-passing-exercises/lesson-3-implementing-message-passing/grpc-demo (master)$ python3 writer.py
Sending sample payload...
'''

# server response:
'''
(udacity_msg_3) phaeton@SCHNABEL:/mnt/d/repo/udacity/udacity-cd0309-message-passing-exercises/lesson-3-implementing-message-passing/grpc-demo (master)$ python3 main.py
Server starting on port 5005...
{'name': 'Non-Stick Frying Pan', 'brand_name': 'Rêve du Chef', 'id': 4, 'weight': 4.5}
'''
