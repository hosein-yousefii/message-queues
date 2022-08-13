#!/bin/bash
#check docker container namespaces and
#show their differences and similarity.
#MAINTAINER: Hosein Yousefi <yousefi.hosein.o@gmail.com>

if [[ ! -e venv ]]; then

        echo "creating python environment..."
        python3 -m venv venv
        . venv/bin/activate
        pip install -r requirements.txt &>/dev/null
	docker build -t amq:amq activemq-image/
fi

case $1 in

        remove)
                docker rm -v -f activemq
        ;;

        *)
		docker run -d --name activemq -p 8161:8161 -p 5672:5672 -p 61613:61613 amq:amq &>/dev/null
		sleep 5s
                echo """

	                Activemq is ready to publish and subsribe messages,
                        use python codes for performance testing,
                        use dashboard to check i/o rate,

                        user: admin
                        password: admin

                        http://localhost:8161

                        amq port: 5672

source venv/bin/activate

python python/amqp/sender.py &
python python/amqp/receiver.py

python python/stomp/publisher.py &
python python/stomp/subscriber.py

                """
        ;;

esac
