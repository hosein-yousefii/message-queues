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
	

	echo "Starting redis..."

	docker run --name redis -d -p 6379:6379 redis

}

cluster () {
	cd docker
	./cluster.sh create
	cd -
}

case $1 in

        cluster)
		cluster
		sed -i "s/host='.*'/host='$(grep redis-1 docker/redis-cluster.info |awk -F: '{print $2}'|sed 's/ //g')'/" python/publisher.py
		sed -i "s/host='.*'/host='$(grep redis-1 docker/redis-cluster.info |awk -F: '{print $2}'|sed 's/ //g')'/" python/subscriber.py
		sleep 15s

		echo """
			redis is ready to publish and subsribe messages,
			use python codes,

source venv/bin/activate
python python/subscriber.py &
python python/publisher.py 

		"""	
        ;;

	remove)
		cd docker
		docker ps| grep redis-2 && ./cluster.sh remove || docker rm -f redis
		cd -
		sed -i "s/host='.*'/host='localhost'/" python/publisher.py
                sed -i "s/host='.*'/host='localhost'/" python/subscriber.py
	;;

        *)
                simple
		sleep 5s
	        echo """
                        redis is ready to publish and subsribe messages,
                        use python codes,

                        source venv/bin/activate
                        python python/subscriber.py &
                        python python/publisher.py


                """
	;;
esac


