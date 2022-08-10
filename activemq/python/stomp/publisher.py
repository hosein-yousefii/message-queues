import stomp


conn = stomp.Connection([('localhost', 61613)])
conn.connect('admin', 'admin', wait=True)

while True:
    conn.send('/queue/test', 'test message')
