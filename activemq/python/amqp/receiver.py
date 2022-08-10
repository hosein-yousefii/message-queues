from __future__ import print_function

from proton.handlers import MessagingHandler
from proton.reactor import Container

url = 'amqp://admin:admin@127.0.0.1:5672/queue://q'

class Receiver(MessagingHandler):
    def __init__(self, url, messages_to_receive=1000000):
        super(Receiver, self).__init__()
        self.url = url
        self._messages_to_receive = messages_to_receive
        self._messages_actually_received = 0
        self._stopping = False

    def on_start(self, event):
        event.container.create_receiver(self.url)

    def on_message(self, event):
        if self._stopping:
            return

        print(event.message)
        self._messages_actually_received += 1
        if self._messages_actually_received == self._messages_to_receive:
            event.connection.close()
            self._stopping = True

    def on_transport_error(self, event):
        raise Exception(event.transport.condition)


if __name__ == "__main__":
    try:
        Container(Receiver(url)).run()
    except KeyboardInterrupt:
        pass
