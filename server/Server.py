import threading, socket
from Client import Client

class Server:
  def __init__(self, port):
    self.host = 'localhost'
    self.port = port
    self.clients = {}
    self.socket = None
    self.commandThread = None
    self.start()

  def start(self):
    self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    self.socket.bind((self.host, self.port))
    self.socket.listen(5)
    print('Server started on port', self.port)
    self.commandThread = threading.Thread(target=self.command)
    self.commandThread.start()
    while True:
      client, address = self.socket.accept()
      print('Client connected:', address)
      threading.Thread(target=self.handleClient, args=(client, address)).start()

  def handleClient(self, client, address):
    with client:
      name = client.recv(1024).decode()
      if name in self.clients:
        client.close()
        return
      client = Client(client, address, name)
      self.clients[name] = client

      while True:
        data = client.recv()
        if not data:
          break
        print(data)
        client.sendall(data)

    del self.clients[name]
  
  def send(self, data, name=None):
    if name and name in self.clients:
      self.clients[name].send(data)
      return
    for client in self.clients.values():
      client.send(data)

  def command(self):
    while True:
      command = input().split(' ')
      cmd = command.pop(0)
      if cmd == 'send':
        name = command.pop(0)
        data = ' '.join(command)
        self.send(data, name)
      if cmd == 'broadcast':
        data = ' '.join(command)
        self.send(data)
      if cmd == 'list':
        if len(self.clients):
          print(', '.join(self.clients.keys()))
        else:
          print('Ninguem conectado')