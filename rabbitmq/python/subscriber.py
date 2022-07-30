import pika

i = 0
def callback(ch, method, properties, body):
    global i
    print(f"Received: {i}")
    i += 1

connection = pika.BlockingConnection(pika.ConnectionParameters(host='localhost', port='5672'))

channel = connection.channel()

channel.basic_consume(queue='hello', on_message_callback=callback, auto_ack=True)

print(' [*] Waiting for messages. To exit press CTRL+C')

channel.start_consuming()


