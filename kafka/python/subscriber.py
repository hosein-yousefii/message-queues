from kafka import KafkaConsumer
from kafka import TopicPartition

consumer = KafkaConsumer(bootstrap_servers='localhost:9092')
#print(consumer.topics())
#consumer.subscribe('foobar')

print('consumer is listening for new messages')

i = 0
while True:
    consumer.assign([TopicPartition('foobar', 0)])
    msg = next(consumer)
    print(msg.value.decode('utf-8'))
    print(i)
    i += 1
