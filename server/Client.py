class Client:
  def __init__(self, conn, addr, name):
    self.conn = conn
    self.addr = addr
    self.name = name
    self.pontos = 0
  
  def __str__(self):
    return self.name

  def send(self, msg):
    try:
      self.conn.send(msg.encode())
    except Exception as e:
      print(self.name, e)

  def recv(self):
    return self.conn.recv(1024).decode()

  def sendall(self, msg):
    self.conn.sendall(msg.encode())

  def add_pontos(self, pontos):
    self.pontos += pontos