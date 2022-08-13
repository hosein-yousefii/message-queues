from redis import Redis
from json import loads
from base64 import b64decode

redis = Redis(decode_responses=True, host='localhost', port=6379)

if redis.ping() is False:
        raise Exception("Couldn't connect to redis.")

pubsub = redis.pubsub()

pubsub.subscribe("new_user_created")

i = 0

for message in pubsub.listen():
        if message["type"] == "message":
                user = loads(b64decode(message["data"]).decode("utf8"))
                #print(f"Going to active user {user['username']}")
                print(i)
                i += 1
