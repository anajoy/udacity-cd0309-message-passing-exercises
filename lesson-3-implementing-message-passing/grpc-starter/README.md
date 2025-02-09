## 1. Use Cases of gRPC

Plan for the gRPC service by creating the protobuf message and computer ordering service.

To customize the computer orders, we want to allow users to specify the equipment that they want on the computer. An order should also include the user who created the order, the status of the order, and the time an order was placed.

Using the proto3 syntax, create the message and services for our computer ordering application. You may find it useful to use your previous JSON solution as a starting point and reference the protobuf ([protobuf](https://protobuf.dev/programming-guides/proto3/)) documentation .

- Create a protibuf message for the computer order using proto3 syntax
- Create a protobuf service for the computer service using proto3 syntax
- Compare the tradeoffs in the experience with using protobufs versus JSON

## 2. Generating gRPC files
`pip install grpcio-tools grpcio`

`python -m grpc_tools.protoc -I./ --python_out=./ --grpc_python_out=./ item.proto`
