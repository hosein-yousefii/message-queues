#!/bin/bash
#check docker container namespaces and
#show their differences and similarity.
#MAINTAINER: Hosein Yousefi <yousefi.hosein.o@gmail.com>

if [[ ! -e venv ]]; then

        echo "creating python environment..."
        python3 -m venv venv
        . venv/bin/activate
        pip install -r requirements.txt &>/dev/null
fi

case $1 in

        remove)
                docker-compose -f docker/docker-compose.yaml down -v
        ;;

        *)
		docker-compose -f docker/docker-compose.yaml up -d
		sleep 5s
                echo """

	                kafka is ready to publish and subsribe messages,
                        use python codes for connecting,
                        use dashboard to check topics,

			dashboard: http://localhost:8080

			source venv/bin/activate
			python python/publisher.py
			python python/subscriber.py


                """
        ;;

esac
