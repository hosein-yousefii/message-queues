import os
import time
import stomp

i = 0

class MyListener(stomp.ConnectionListener):
    def __init__(self, conn):
        self.conn = conn

    def on_error(self, frame):
        print('received an error "%s"' % frame.body)

    def on_message(self, frame):
        global i
        print(f"{i} {frame.headers}")
        #print('received a message "%s"' % frame.body)
        i += 1

    def on_disconnected(self):
        print('disconnected')

conn = stomp.Connection([('localhost', 61613)], heartbeats=(4000, 4000))
conn.set_listener('', MyListener(conn))
conn.connect('admin', 'admin', wait=True)
conn.subscribe(destination='/queue/test', id=1, ack='auto')
time.sleep(60)
#conn.disconnect()
