from __future__ import print_function
from proton.handlers import MessagingHandler
from proton.reactor import Container
from proton import Message


url = 'amqp://admin:admin@127.0.0.1:5672/queue://q'


class Sender(MessagingHandler):
    def __init__(self, url, messages):
        super(Sender, self).__init__()
        self.url = url
        self._messages = messages
        self._message_index = 0
        self._sent_count = 0
        self._confirmed_count = 0

    def on_start(self, event):
        event.container.create_sender(self.url)

    def on_sendable(self, event):
        while event.sender.credit and self._sent_count < len(self._messages):
            message = self._messages[self._message_index]
#            print(message)
            event.sender.send(message)
            self._message_index += 1
            self._sent_count += 1

    def on_accepted(self, event):
        self._confirmed_count += 1
        if self._confirmed_count == len(self._messages):
            event.connection.close()

    def on_transport_error(self, event):
        raise Exception(event.transport.condition)

messages = [Message(subject='s%d' % i, body='b%d' % i) for i in range(1000000)]


if __name__ == "__main__":
    try:
        Container(Sender(url, messages)).run()
    except KeyboardInterrupt:
        pass
