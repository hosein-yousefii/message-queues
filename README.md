# MESSAGE-QUEUES
A simple code to publish and subscribe with Rabbitmq, Activemq, Kafka and Redis.

[![GitHub license](https://img.shields.io/github/license/hosein-yousefii/message-queues)](https://github.com/hosein-yousefii/message-queues/blob/master/LICENSE)
![LinkedIn](https://shields.io/badge/style-hoseinyousefi-black?logo=linkedin&label=LinkedIn&link=https://www.linkedin.com/in/hoseinyousefi)


Implement services (Rabbitmq, Activemq,...) on docker, and create simple queue using python.


## What are Microservices?

Also known as the microservice architecture - is an architectural style that structures an application as a collection of services that are

    Highly maintainable and testable
    Loosely coupled
    Independently deployable
    Organized around business capabilities
    Owned by a small team

The microservice architecture enables the rapid, frequent and reliable delivery of large, complex applications.

## What is the MVC pattern?

Is a pattern in software design commonly used to implement user interfaces, data, and controlling logic. It emphasizes a separation between the software's business logic and display. This "separation of concerns" provides for a better division of labor and improved maintenance. 

![alt text](https://www.researchgate.net/publication/337601038/figure/fig2/AS:830217782300694@1574950752978/Structure-diagram-of-MVC-design-pattern.jpg)


## What is UnitTest?

Is a way of testing a unit - the smallest piece of code that can be logically isolated in a system.


## What is Flask?

Flask is a micro web framework written in Python. It is classified as a microframework because it does not require particular tools or libraries. It has no database abstraction layer, form validation, or any other components where pre-existing third-party libraries provide common functions.


## What is cloud-native?

Cloud native computing is an approach in software development that utilizes cloud computing to "build and run scalable applications in modern, dynamic environments such as public, private, and hybrid clouds".


# GET STARTED !

There are several environment variables in each service on the config directory, but you are able to set them in your environment instead of changing any file.
I mention two important one that you may need.

For droput authentication:
```
# If you do not set this, the application will use sqlite instead.

export DROPUT_AUTH_DATABASE_URI=mysql+pymysql://user:password@ip:port/DB

```

For droput message:
```
# It's the default value, You don't need to change it.
export DROPUT_AUTH_URL=http://127.0.0.1:5000

# If you do not set this, the application will use sqlite instead.
export DROPUT_MSG_DATABASE_URI=mysql+pymysql://user:password@ip:port/DB

```

!!! ATTENTION !!!

Default sqlite databases will be created on /tmp/{droput_auth.db,droput_msg.db}


# USAGE

For the first time you need to execute the start script or follow its structure to run applications:
```
./start.sh
```

After that you can run as follow:
```
# for dropt authentication

export FLASK_APP=droput_auth
cd droput_authentication
. venv/bin/activate
flask run &
deactivate

# for droput messaging

export FLASK_APP=droput_msg
cd droput_message
. venv/bin/activate
flask run -p 5001 &
deactivate
```

Use "ApiCommands file" to know about APIs and their responsibilities.


# How to contribute?

You can fork and develop your idea.
Copyright 2021 Hosein Yousefi <yousefi.hosein.o@gmail.com>





