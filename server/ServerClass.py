import threading, socket, time, random
from Client import Client

PROTOCOLO = {
  'T': 'TEMA',
  'R': 'RODADA',
  'O': 'OWNER',
  'A': 'ACABOU O TEMPO',
  'M': 'MENSAGEM',
  'L': 'LISTA JOGADORES',
  'P': 'LISTA DE PONTOS',
  'C': 'CONECTADO',
  't': 'TEMPO',
}

class Server:
  def __init__(self, port):
    self.host = 'localhost'
    self.port = port
    self.clients = {}
    self.clientNames = self.clients.keys()
    self.socket = None
    self.commandThread = None
    self.tema = []
    self.rodada = 0
    self.startRound = 0
    self.owner = None
    self.correct = 0
    self.started = False
    self.respostaCensurada = False
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
    try:
      with client:
        name = client.recv(1024).decode()
        if name in self.clientNames:
          client.close()
          return
        client = Client(client, address, name)
        self.clients[name] = client

        self.handleConnect(name)

        while True:
          data = client.recv()
          if not data:
            break
          
          data = list(data)
          protocolo = data.pop(0)
          data = ''.join(data)

          print(protocolo, data)

          if protocolo == 'T':
            self.handleTema(data, name)
            return

          self.send(f'M{client}: {data}')        
    except Exception as e:
      print(f'Lost connection to client {client} because of {e}')
    self.handleDisconnect(name)
  
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
          print(', '.join(self.clientNames))
        else:
          print('Ninguem conectado')
      if cmd == 'rodada':
        r = threading.Thread(target=self.round)
        r.start()

  def calcTempoRestante(self):
    return int(60 - self.roundDuration())

  def handleConnect(self, name):
    self.send('C', name)
    self.send(f'M{name} conectou')
    if self.started:
      listaJogadoresPontos = ';'.join(list(map(lambda x: f'{x.name};{x.pontos}', self.clients)))
      self.send(f'P{listaJogadoresPontos}')
      self.send(f'R{self.rodada}')
      self.send(f'O{self.owner}')
      self.send(f't{self.calcTempoRestante()}')
      self.sendTema()
    else:
      listaJogadores = self.clientNames.join(';')
      self.send(f'L{listaJogadores}')

  def sendTema(self):
    if not self.respostaCensurada:
      return
    currentTema = self.tema[self.rodada - 1]

    tema = currentTema['tema']
    dica = currentTema['dica']
    resposta = self.respostaCensurada()
  
    self.send(f'T{tema};{dica};{resposta}')

  def handleDisconnect(self, name):
    del self.clients[name]
    self.send(f'M{name} desconectou')
    if self.started:
      listaJogadoresPontos = ';'.join(list(map(lambda x: f'{x.name};{x.pontos}', self.clients)))
      self.send(f'P{listaJogadoresPontos}')
    else:
      listaJogadores = self.clientNames.join(';')
      self.send(f'L{listaJogadores}')
    

  def handleTema(self, data, clientName):
    if self.owner != clientName:
      self.send('Mvoce não e o dono da rodada', clientName)
      return

    tema, dica, resposta = data.split(';')

    print(f'RODADA [{self.rodada}] -> {tema} - {dica} - {resposta}')

    self.tema.append({
      'tema': tema,
      'dica': dica,
      'resposta': resposta,
      'dono': clientName
    })

  def setOwner(self):
    self.owner = list(self.clientNames)[self.rodada % len(self.clients)]
    self.send(f'O{self.owner}')
    self.rodada += 1

  def setStartRound(self):
    self.startRound = time.time()

  def setupRound(self):
    self.setOwner()
    self.setStartRound()
    self.correct = 0

  def getRespostaCensurada(self, resposta, showOrder):
    #TODO: arrumar isso aqui
    JT = len(self.clients) - 1
    JA = self.correct
    L = len(resposta)
    LL = 0
    TA = self.roundDuration()
    TT = 60

    x = ((JT)/(JA+1)) * L/4
    if ( x > L/2 ):
      LL = L/2
    else:
      LL = x

    LL = int(LL * (TA/TT) * 2)

    respostaCensurada = list('_' * int(L))
    respostaList = list(resposta)

    print(f'{resposta}')

    for i in range(LL):
      respostaCensurada[showOrder[i]] = respostaList[showOrder[i]]

    return ''.join(respostaCensurada)

  def roundDuration(self):
    return time.time() - self.startRound

  def round(self):
    self.respostaCensurada = False
    self.setupRound()
    self.send(f'R{self.rodada}')

    while self.rodada != len(self.tema):
      if self.roundDuration() > 10:
        self.send(f'A{self.owner}')
        self.setupRound()


    currentTema = self.tema[self.rodada - 1]

    tema = currentTema['tema']
    dica = currentTema['dica']
    resposta = currentTema['resposta']

    showOrder = random.shuffle(list(range(len(resposta))))
    sent = 0

    self.setStartRound()
    self.send(f't{self.calcTempoRestante()}')
    while sent != 12:
      self.respostaCensurada = self.getRespostaCensurada(resposta, showOrder)
      self.sendTema()
      sent += 1
      time.sleep(5)