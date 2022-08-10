from redis import Redis
from json import dumps
from base64 import b64encode

redis = Redis(decode_responses=True)

if redis.ping() is False:
        raise Exception("Couldn't connect to redis.")

user = {
        "username": "test",
        "email": "a@a.com"
}

#print(dumps(user))             #convert to string

#print(b64encode(dumps(user).encode("ascii")))          #convert to byte
print("publishing messages")

for i in range(10000):
    redis.publish("new_user_created", b64encode(dumps(user).encode("ascii")))
    print(i)
