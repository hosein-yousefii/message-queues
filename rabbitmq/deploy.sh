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

simple () {
	echo "Starting rabbit-1"

	docker run -d --rm --net rabbit -v ${PWD}/docker/rabbit-1/:/config/ -e RABBITMQ_CONFIG_FILE=/config/rabbitmq -e RABBITMQ_ERLANG_COOKIE=ETOBVBEFXUPGETFECHSQ --hostname rabbit-1 --name rabbit-1 -p 8081:15672 -p 5672:5672 rabbitmq:3.9.21-management &>/dev/null

	echo "Starting rabbit-2"

	docker run -d --rm --net rabbit -v ${PWD}/docker/rabbit-2/:/config/ -e RABBITMQ_CONFIG_FILE=/config/rabbitmq -e RABBITMQ_ERLANG_COOKIE=ETOBVBEFXUPGETFECHSQ --hostname rabbit-2 --name rabbit-2 -p 8082:15672 -p 5673:5672 rabbitmq:3.9.21-management &>/dev/null

	echo "Starting rabbit-3"

	docker run -d --rm --net rabbit -v ${PWD}/docker/rabbit-3/:/config/ -e RABBITMQ_CONFIG_FILE=/config/rabbitmq -e RABBITMQ_ERLANG_COOKIE=ETOBVBEFXUPGETFECHSQ --hostname rabbit-3 --name rabbit-3 -p 8083:15672 -p 5674:5672 rabbitmq:3.9.21-management &>/dev/null
}

mirror () {

	docker exec -it rabbit-1 rabbitmq-plugins enable rabbitmq_federation &>/dev/null 
	docker exec -it rabbit-2 rabbitmq-plugins enable rabbitmq_federation &>/dev/null
	docker exec -it rabbit-3 rabbitmq-plugins enable rabbitmq_federation &>/dev/null
	docker exec -it rabbit-1 rabbitmqctl set_policy ha-fed ".*" '{"federation-upstream-set":"all","ha-sync-mode":"automatic", "ha-mode":"nodes", "ha-params":["rabbit@rabbit-1","rabbit@rabbit-2","rabbit@rabbit-3"]}' --priority 1 --apply-to queues &>/dev/null
}

case $1 in

        mirror)
		simple
		sleep 15s
                mirror

		echo """
			system is ready to publish and subsribe messages,
			use python codes for performance testing,
			use dashboard to check i/o rate,

			user: guest
			password: guest

			http://localhost:8081

			source venv/bin/activate
			python python/publisher.py &
			python python/subscriber.py

		"""	
        ;;

	remove)
		docker rm -f rabbit-1 rabbit-2 rabbit-3
	;;

        *)
                simple
		sleep 15s
	        echo """
                        system is ready to publish and subsribe messages,
                        use python codes for performance testing,
                        use dashboard to check i/o rate,

                        user: guest
                        password: guest

                        http://localhost:8081

                        source venv/bin/activate
                        python python/publisher.py &
                        python python/subscriber.py

                """
	;;
esac


