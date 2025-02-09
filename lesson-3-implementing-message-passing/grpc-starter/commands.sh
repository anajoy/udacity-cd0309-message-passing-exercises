# code applied to fullfil the exercise: Using gRPC
cd /mnt/d/repo/udacity/udacity-cd0309-message-passing-exercises/lesson-3-implementing-message-passing/grpc-starter
workon udacity_msg_3
pip install grpcio-tools grpcio
# adapt the item.proto in the way to fullfil the requriements of the exercise
cat order.proto
...
syntax = "proto3";

message OrderMessage {
  enum Status {
    QUEUED = 0;
    PROCESSING = 1;
    COMPLETED = 2;
    FAILED = 3;
  }

  enum Equipment {
    KEYBOARD = 0;
    MOUSE = 1;
    WEBCAM = 2;
    MONITOR = 3;
  }

  string id = 1;
  string created_by = 2;
  Status status = 3;
  string created_at = 4;
  repeated Equipment equipment = 5;
}

message Empty {

}

message OrderMessageList {
  repeated OrderMessage orders = 1;
}

service OrderService {
  rpc Create(OrderMessage) returns (OrderMessage);
  rpc Get(Empty) returns (OrderMessageList);
}
'''

python3 -m grpc_tools.protoc -I./ --python_out=./ --grpc_python_out=./ order.proto
python3 main.py

'''
(udacity_msg_3) phaeton@SCHNABEL:/mnt/d/repo/udacity/udacity-cd0309-message-passing-exercises/lesson-3-implementing-message-passing/grpc-starter (master)$ python3 main.py
Server starting on port 5005...
'''

# open a new console window
cd /mnt/d/repo/udacity/udacity-cd0309-message-passing-exercises/lesson-3-implementing-message-passing/grpc-starter
workon udacity_msg_3

# test to get order list
python3 getter.py

# client response:
'''
(udacity_msg_3) phaeton@SCHNABEL:/mnt/d/repo/udacity/udacity-cd0309-message-passing-exercises/lesson-3-implementing-message-passing/grpc-starter (master)$ python3 getter.py
Sending sample payload...
orders {
  id: "1001"
  created_by: "USER15"
  created_at: "2025-02-09"
  equipment: KEYBOARD
  equipment: MOUSE
}
orders {
  id: "1002"
  created_by: "USER15"
  created_at: "2025-02-10"
  equipment: WEBCAM
  equipment: MONITOR
}
'''
# Remark: enum STATUS is not retrieved! Must be reworked to work on higher version of protobuf after upgrade of protobuf to Python C++ extensions
'''
TypeError: Descriptors cannot be created directly.
If this call came from a _pb2.py file, your generated code is out of date and must be regenerated with protoc >= 3.19.0.
If you cannot immediately regenerate your protos, some other possible workarounds are:
 1. Downgrade the protobuf package to 3.20.x or lower.
 2. Set PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python (but this will use pure-Python parsing and will be much slower).

More information: https://developers.google.com/protocol-buffers/docs/news/2022-05-06#python-updates
                  https://docs.python.org/3/extending/building.html
                  https://googleapis.dev/python/protobuf/latest/google/protobuf/message.html
'''

# server response:
'''
(udacity_msg_3) phaeton@SCHNABEL:/mnt/d/repo/udacity/udacity-cd0309-message-passing-exercises/lesson-3-implementing-message-passing/grpc-starter (master)$ python3 main.py
Server starting on port 5005...
orders {
  id: "1001"
  created_by: "USER15"
  created_at: "2025-02-09"
  equipment: KEYBOARD
  equipment: MOUSE
}
orders {
  id: "1002"
  created_by: "USER15"
  created_at: "2025-02-10"
  equipment: WEBCAM
  equipment: MONITOR
}
'''

# test to create order
python3 writer.py

# client response:
'''
(udacity_msg_3) phaeton@SCHNABEL:/mnt/d/repo/udacity/udacity-cd0309-message-passing-exercises/lesson-3-implementing-message-passing/grpc-starter (master)$ python3 writer.py
Sending sample payload for order 1
Traceback (most recent call last):
  File "/mnt/d/repo/udacity/udacity-cd0309-message-passing-exercises/lesson-3-implementing-message-passing/grpc-starter/writer.py", line 34, in <module>
    response = stub.Create(order)
  File "/home/phaeton/Envs/udacity_msg_3/lib/python3.10/site-packages/grpc/_channel.py", line 1181, in __call__
    return _end_unary_response_blocking(state, call, False, None)
  File "/home/phaeton/Envs/udacity_msg_3/lib/python3.10/site-packages/grpc/_channel.py", line 1006, in _end_unary_response_blocking
    raise _InactiveRpcError(state)  # pytype: disable=not-instantiable
grpc._channel._InactiveRpcError: <_InactiveRpcError of RPC that terminated with:
        status = StatusCode.UNKNOWN
        details = "Exception calling application: 'google._upb._message.RepeatedScalarContainer' object cannot be interpreted as an integer"
        debug_error_string = "UNKNOWN:Error received from peer  {created_time:"2025-02-09T17:23:38.808564363+01:00", grpc_status:2, grpc_message:"Exception calling application: \'google._upb._message.RepeatedScalarContainer\' object cannot be interpreted as an integer"}"
>
'''

# server response:
'''
(udacity_msg_3) phaeton@SCHNABEL:/mnt/d/repo/udacity/udacity-cd0309-message-passing-exercises/lesson-3-implementing-message-passing/grpc-starter (master)$ python3 main.py
Server starting on port 5005...

Received a message!
{'id': '1001', 'created_by': 'USER14', 'status': 0, 'created_at': '2025-02-09', 'equipment': [[0, 1]]}
'''
