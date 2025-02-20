# Excercise: Using message queues

## How Can a Message Queue Help

### Question:
How can a message queue can help alleviate the increased API load? What problems are solved and what problems still exist?

### My Answer:
Apache Kafka can handle large volumes of event messages very reliable and efficiently. It's the best candidate for running data streaming platforms. Such a system is able to hold messages when the counterpart is offline or overloaded. The asynchrous message service is efficient, as it does not require a lot of memory to operate. Basically the message persistence is achieved by writing the messages to queues persisted in the FS.

### Given Solution:
Kafka is very useful for handling large volumes of data -- especially data that comes in as events. We will be expecting a large stream of events as they come in from our service. This will help prevent our server from crashing due to load but our messages will be backlogged as we won’t be able to process them more quickly.


## How Can Distributed Message Broker Help?

### Question:
How can a distributed message broker help with the design of the computer order tracker? What are the pros and cons of using this over a simple database?

### My Answer:
As already stated message queues are very efficient in persisting data, that should not live forever. Databases are designed for other use cases as long term storage and therefore not optimized for a intermediate or short lifetime offered by message brokers. Therefore a database would be limited in in offering the same scalability and performance in writing and reading data streams.

### Given solution:
Databases are designed for specific use cases and often not optimized to function as a message broker. Using a queue should require high write performance. MySQL will lock table rows and prevent more than one resource from updating a row at a time. This can cause delays and even issues for data entering our makeshift queue. This implementation will also require a lot of custom logic to reshape the database into a queue.


## Thinking Like a Cloud Native Engineer

### Question:
Have you worked on any projects where message queues would have been helpful? Please describe them. Can you think of other good use cases for message queues?


### My answer:
I worked for two companies active in the Card Payment industry and responsible for fraud detection applications. Both did have challenges to incorporate a modern reliable message queuing solution for the interfaces and finally also the payment transactions. The first one did miss the oportunity to introduce Kafka as key technology for messaging. They mostly still rely on synchronous communication based on REST and file based interfaces. The second one introduced Kafka but did fail to operate the system reliable. Meanwhile Kafka has not been completely given up and plays a niche role as interface for masterdata.


# Exercise: Trade-offs: Task list

## GraphQL vs. REST and gRPC

### Question:

Research how GraphQL is used for message passing and compare your findings against REST and gRPC. Start with the official [GraphQL](https://graphql.org/learn/) Documentation  and leverage any other resources that may be helpful.

- Compare and contrast tradeoffs between GraphQL and REST
- Compare and contrast tradeoff between GrapphQL and gRPC

GraphQL has his advantages in beeing able to apply queries on the internal data structures. This new API is flexible regarding adaption and extending the queries by handling fields and methods (functions) over a simple syntax based on json.

#### Compared to REST:

'+ Does not depend on the http protocols and its methods'\
'- When used on external communication, security and dependend on counterpart implementation'

#### Compared to gRPC:

'+ Allows not only server to server communication but support also client to server architectures'\
'- As the data transfer format is JSON, the traffic payload is higher compared to protobuffer binary formats used in gRPC'

### Given solution:

#### Compared with REST
When using REST, we have to make multiple requests to retrieve our data.

**Pros**\
_REST_
- May over-fetch data where only a few fields of a large request are needed.
- An API client may have to chain multiple REST requests to retrieve all the necessary data.

_GraphQL_

- GraphQL reduces this overhead by allowing the client to query for a specific subset of data in one query.
- GraphQL reduces overhead and can provide a more pleasant experience for users.

**Cons**\
When we need high throughput in API performance or have a use case that doesn't merit the complexity of GraphQL, REST is a fine solution.

_REST_

- REST is more straightforward

_GraphQL_

- GraphQL makes things more pleasant for users at the expense of more work for the application.

#### Compared with gRPC

**Pros**\
_GraphQL_

- Often, GraphQL is optimized for flexible queries that provide a pleasant experience for integrations.

_gRPC_

- gRPC is often used in situations where low latency requests are desired, such as between internal systems and streamed data.

**Cons**\
_GraphQL_

- Less robust with schema

_gRPC_

- gRPC is optimized for performance and predictability through contracts using protobuf.
- gRPC is more rigid in its schema.
- In general, gRPC also boasts better performance.

It's useful to perform tests against message passing techniques to profile their performance. Here is a great article detailing the performance of gRPC versus GraphQL: [gRPC vs. GraphQL with keep-alive](https://blog.q42.nl/graphql-keep-alive-4379fe1a8b58/).


### Thinking Like a Cloud Native Engineer

#### Question:
How might GraphQL be useful in an application that you have worked on before in the past. How would the developer experience be different with regards to building a GraphQL API and integrating the service?

#### My Answer:
Thinking of a solution for a more perfomant alert and case management in fraud dectection applications it would make sense to evaluate GraphQL as interface for quering data with less overhead compared to database client server queries fetching too much data at once.

### Updating Orders Service:

#### Question:
List five tasks that will be needed in REST, gRPC, and Kafka message and implementation to make modifications to our existing computer orders schema to include a type field

#### Answer:
- REST: rework request and response order message to include a new (below details: computer_type)
- gRPC: rework message and add a new enum for computer_type
- gRPC: rework message and remove Desktop for enum equipement
- gRPC: Recreate the protobuf binary
- Kafka: Extend the method create_order and retrieve_order to support a field computer_type

#### Solution:
The following five items are tasks that I will present to my team:

- REST message interface
- gRPC protobuf message
- Flask code to handle new field
- gRPC server code to handle new field
- Update Kafka consumers to expect the new field

Note that there are different solutions to this exercise and that your solution may not look exactly like mine.

### Reflection on Solution: [Final Exercise]
#### Question:
Why is it useful to present a list like this when you propose changes for your team to work on?

- It helps to boil down the tasks to single work items as features, story, etc.
- It is base for a discussion on task adopting from given input on a review.

### Thinking Like a Cloud Native Developer

#### Question:
How was your experience with integrating a Flask REST API with a Kafka queue? How might integrating a REST API with a Kafka queue be useful in large production systems?

#### Answer:
- For getting it done I did use quite a lot of time. The diffculties arised about the lack of experience wirking with http REST request an dtesting it by using postman.
- Integrating it in large production environments will add relilabilty to the communication, as the message will get persisted in a queue before being processed by an http webserver. It's actually a safety measure to prevent a timeout base on overload or service interrupiton based on the backend failure.

### Applying OpenAPI
Create an OpenAPI specification for our computer orders REST API. We want to make sure that users of the API know how to set up their integrations to retrieve all orders and create a new order.

#### Approach:
Use the Swagger Editor to generate and test the API documentation: https://editor.swagger.io/

### Thinking Like a Cloud Native Developer (OpenAPI 1)

#### Question:
How might you find OpenAPI useful in your RESTful API implementations? When would it not make sense to use OpenAPI?

#### Answer:
- OpenAPI is usefull to support API extensions and changes for deveolopers and cnnecting partners.
- It helps to support several versions of API defintitions operated in parallel.

### Thinking Like a Cloud Native Developer (openAPI 2)

#### Question:
Once the new endpoints are set, what other parts of the code will we need to modify?

#### Answer:
- We could modify the logic inside the new v2 API
- We could change the data structure of our v2 API
- We should rework our shared codebase to support both versions of our API (for example in services.py)

### Thinking Like a Cloud Native Developer (Messaging techniques, API's)

#### Question:
Choose at least two of the strategies discussed in this lesson and describe how using those strategies would have helped you on an earlier project.

#### Answer:
- Combination of techniques: For our card payment fraud detection application we did rely too much only on common REST APIs for internal and external communication.
We could have done a better job, if we would have used REST for the low traffic and confirm it by a callback, gRPC for our high traffic real-time and Kafka for our near real-time high traffic interfaces
- Future proofing our message passing: Our software provider did often introduce based on new feature requests extension of existing API's or introduce new API's. Mostly all updates were delivered were not working due to bad architecture specification or developer implementation. A very good example of missing appropriate API documentation or skipping any API unit testing at developer’s side.

### Thinking Like a Cloud Native Developer (Bad use cases)

#### Question:
We discussed situations in which these strategies can be useful. Can you think of situations when these strategies would not be useful and would add unnecessary complexity to your projects?

##### Answer:
- A bad use case would be to introduce a complex additional operating infrastructure as Kafka in a company, where no resposible team can be found to operate it reliable. Evaluate alternative options as RabbitMQ Streaming for a suited use case.
- Another suboptimal use case would be to introduce gRPC for communication over API's to external applications, where you have no control on development standards and security infrastructure. Using an API Gateway as Kong could fill the gap by adding more security and decoupling company diversity risks.
