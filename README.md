# MESSAGE-QUEUES
A simple code to publish and subscribe with Rabbitmq, Activemq, Kafka and Redis.

[![GitHub license](https://img.shields.io/github/license/hosein-yousefii/message-queues)](https://github.com/hosein-yousefii/message-queues/blob/master/LICENSE)
![LinkedIn](https://shields.io/badge/style-hoseinyousefi-black?logo=linkedin&label=LinkedIn&link=https://www.linkedin.com/in/hoseinyousefi)


Implement services (Rabbitmq, Activemq,...) on docker, and create simple queue(pub,sub) using python.

In this repo 4 famous message brokers (kafka which is used more in data streaming) are implemented and integrated with simple python code. Before doing any thing let's discuss what are queues and these services.

## Rabbitmq

RabbitMQ is an open-source message-broker software that originally implemented the Advanced Message Queuing Protocol and has since been extended with a plug-in architecture to support Streaming Text Oriented Messaging Protocol, MQ Telemetry Transport, and other protocols.

- [X] Rabbitmq is used as a single node and in cluster mode.
- [X] Auto ack is enabled.
- [X] AMQP is used.
- [X] Dashboard is enabled on port 8081

### Rabbitmq usage:

You are able to deploy rabbitmq in two ways:

1- single node

2- mirror (queue replication)

```bash
cd rabbitmq
# for single mode
./deploy.sh

# for mirror mode
./deploy.sh mirror

# to remove containers
./deploy.sh remove
```

After implementation you can run python codes:

```bash
source venv/bin/activate
python python/publisher.py &
python python/subscriber.py
```

Also, dashboard is available on localhost:8081

________________________________________________

## Activemq

Apache ActiveMQ® is the most popular open source, multi-protocol, Java-based message broker. It supports industry standard protocols so users get the benefits of client choices across a broad range of languages and platforms. Connect from clients written in JavaScript, C, C++, Python, .Net, and more. Integrate your multi-platform applications using the ubiquitous AMQP protocol. Exchange messages between your web applications using STOMP over websockets. Manage your IoT devices using MQTT. Support your existing JMS infrastructure and beyond.

- [X] Activemq is used as single server
- [X] AMQP(port=5672) and STOMP(port=61613) is available
- [X] Dashboard is on port 8161
- [X] Auto ack is enabled

### Activemq usage:

```bash
cd activemq
# implement it
./deploy.sh

#remove container
./deploy remove
```

You are able to use 2 protocols to communicate:

1- AMQP

2- STOMP

```bash
source venv/bin/activate

#AMQP
python python/ampq/sender.py &
python python/ampq/receiver.py

#STOMP
python python/stomp/publisher.py &
python python/stomp/subscriber.py
```

Also, dashboard is available on localhost:8161 with user: admin, password: admin.

__________________________________________________

# How to contribute?

You can fork and develop your idea.
Copyright 2021 Hosein Yousefi <yousefi.hosein.o@gmail.com>





