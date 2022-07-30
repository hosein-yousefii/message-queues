echo "Stating rabbit-1"

docker run -d --rm --net rabbit -v ${PWD}/rabbit-1/:/config/ -e RABBITMQ_CONFIG_FILE=/config/rabbitmq -e RABBITMQ_ERLANG_COOKIE=ETOBVBEFXUPGETFECHSQ --hostname rabbit-1 --name rabbit-1 -p 8081:15672 -p 5672:5672 rabbitmq:3.9.21-management

echo "Stating rabbit-2"

docker run -d --rm --net rabbit -v ${PWD}/rabbit-2/:/config/ -e RABBITMQ_CONFIG_FILE=/config/rabbitmq -e RABBITMQ_ERLANG_COOKIE=ETOBVBEFXUPGETFECHSQ --hostname rabbit-2 --name rabbit-2 -p 8082:15672 rabbitmq:3.9.21-management

echo "Stating rabbit-3"

docker run -d --rm --net rabbit -v ${PWD}/rabbit-3/:/config/ -e RABBITMQ_CONFIG_FILE=/config/rabbitmq -e RABBITMQ_ERLANG_COOKIE=ETOBVBEFXUPGETFECHSQ --hostname rabbit-3 --name rabbit-3 -p 8083:15672 rabbitmq:3.9.21-management
