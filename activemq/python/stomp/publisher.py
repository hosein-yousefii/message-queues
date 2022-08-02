import stomp


conn = stomp.Connection([('localhost', 49171)])
conn.connect('admin', 'admin', wait=True)

while True:
    conn.send('/queue/test', 'test message')
