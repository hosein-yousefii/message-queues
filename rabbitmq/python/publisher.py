import pika

connection = pika.BlockingConnection(pika.ConnectionParameters(host='localhost', port='5672'))
channel = connection.channel()

i = 0
while True:
    channel.queue_declare(queue='hello')
    channel.basic_publish(exchange='', routing_key='hello', body='Hello RabbitMQ!')
    i += 1
    #print(f"number: {i}")

connection.close()
