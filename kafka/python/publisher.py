from kafka import KafkaProducer
from datetime import datetime

producer = KafkaProducer(bootstrap_servers='localhost:9092')

i = 0

for i in range(0,10000):
    producer.send('foobar', b'some_message_bytes')
    print(i)
    i = + 1

#producer.flush()

