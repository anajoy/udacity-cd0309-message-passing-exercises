import grpc
import order_pb2
import order_pb2_grpc

"""
Sample implementation of a writer that can be used to write messages to gRPC.
"""
channel = grpc.insecure_channel("localhost:5005")
stub = order_pb2_grpc.OrderServiceStub(channel)


# Update this with desired payload
order = order_pb2.OrderMessage(
    id="1001",
    created_by="USER14",
    status=order_pb2.OrderMessage.Status.QUEUED,
    created_at='2025-02-09',
    equipment=[order_pb2.OrderMessage.Equipment.KEYBOARD, order_pb2.OrderMessage.Equipment.MOUSE]
#    equipment=["KEYBOARD","MOUSE"]
)

'''
order_2 = order_pb2.OrderMessage(
    id="1002",
    created_by="USER14",
    status=order_pb2.OrderMessage.Status.QUEUED,
    created_at='2025-02-10',
    equipment=[order_pb2.OrderMessage.Equipment.WEBCAM,order_pb2.OrderMessage.Equipment.MONITOR]
)
'''

print("Sending sample payload for order 1")
# stub = order_pb2_grpc.OrderServiceStub(channel)
response = stub.Create(order)

# print("Sending sample payload for order 2")
# stub_2 = order_pb2_grpc.OrderServiceStub(channel)
# response = stub_2.Create(order_2)
