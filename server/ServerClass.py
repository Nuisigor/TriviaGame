import threading, socket, time, random
from Client import Client
from Utils import levenshtein

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
  'Y': 'TEMPO DE ESPERA TELA JOGADORES',
  'G': 'JOGO COMECOU',
  'c': 'RESPOSTA CORRETA',
  'N': 'RESPOSTA PROXIMA',
  'W': 'RESPOSTA ERRADA',
  'a': 'TOTAL DE ACERTOS DA RODADA',
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
    self.ownerPos = 0
    self.correct = 0
    self.started = False
    self.respostaCensurada = False
    self.roundAtivo = False
    self.lobbyThread = None
    self.createLobbyThread()
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

  def createLobbyThread(self):
    self.lobbyThread = threading.Thread(target=self.runLobby)
    self.lobbyThread.start()

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
            continue

          if protocolo == 'M' and self.roundAtivo:
            if self.handleAnswer(data, name):
              continue

          self.send(f'M{client}: {data}')        
    except Exception as e:
      print(f'Lost connection to client {client} because of {e}')
    self.handleDisconnect(name)
  
  def send(self, data, name=None):
    print('sending stuff',data,name)
    if name and name in self.clients:
      self.clients[name].send(data + '|')
      return
    for client in self.clients.values():
      client.send(data + '|')

  '''
  self.tema.append({
      'tema': tema,
      'dica': dica,
      'resposta': resposta,
      'dono': clientName,
      'acertos': [],
      'usuariosInicio': len(self.clients) - 1
    })
  '''
  def handleAnswer(self, resposta, name):
    if not self.roundAtivo:
      return

    round = self.tema[self.rodada - 1]

    if round['dono'] == name:
      return

    respostaCorreta = round['resposta']

    if(name not in round['acertos'] and respostaCorreta == resposta):
      self.tema[self.rodada - 1]['acertos'].append(name)
      self.add_ponto(name)
      self.send(f'c{name}')
      self.broadcastInfo()
      return True
    elif(levenshtein(resposta, respostaCorreta) > 0.70):
      self.send(f'N', name)
    else:
      self.send(f'W', name)
    return False


  def add_ponto(self, name, pontos=False):
    pontos = pontos if pontos else 3 * self.calcTempoRestante()
    self.clients[name].add_pontos(pontos)

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

    if not self.started:
      self.lobbyStarted = time.time()
    else:
      self.send('G', name)
    self.broadcastInfo()

  def sendTema(self):
    if not self.respostaCensurada:
      return
    currentTema = self.tema[self.rodada - 1]

    tema = currentTema['tema']
    dica = currentTema['dica']
    resposta = currentTema['resposta'] #self.respostaCensurada()
  
    self.send(f'T{tema};{dica};{resposta}')

  def broadcastInfo(self):
    if self.started:
      
      pontoList = list(map(lambda nome: (nome,self.clients[nome].pontos), self.clients))
      pontoList = sorted(pontoList, key=lambda x: x[1], reverse=True)
      listaJogadoresPontos = ';'.join(list(map(lambda x: f'{x[0]},{x[1]}', pontoList)))

      self.send(f'P{listaJogadoresPontos}')
      if self.calcTempoRestante() > 0:
        self.send(f'R{self.rodada}')
        self.send(f't{self.calcTempoRestante()}')
        self.sendTema()
    else:
      listaJogadores = ';'.join(self.clientNames)
      self.send(f'L{listaJogadores}')

  def handleDisconnect(self, name):
    print(name, 'disconnected')

    del self.clients[name]

    if len(self.clients) < 2:
      self.abort = True

    self.send(f'M{name} desconectou')
    self.broadcastInfo()
    

  def handleTema(self, data, clientName):
    if self.owner != clientName:
      self.send('Mvoce não e o dono da rodada', clientName)
      return

    tema, dica, resposta = data.split(';')

    self.tema.append({
      'tema': tema,
      'dica': dica,
      'resposta': resposta,
      'dono': clientName,
      'acertos': [],
      'usuariosInicio': len(self.clients) - 1
    })

  def setOwner(self):
    self.owner = list(self.clientNames)[self.ownerPos % len(self.clients)]
    self.ownerPos += 1
    self.send(f'O{self.owner}')

  def setStartRound(self):
    self.startRound = time.time()

  def setupRound(self):
    self.setOwner()
    self.setStartRound()
    self.correct = 0

  def getRespostaCensurada(self, resposta, showOrder):
    #TODO: ARRUMAR
    return

  def roundDuration(self):
    return time.time() - self.startRound

  def round(self):
    self.rodada += 1
    self.respostaCensurada = False
    self.roundAtivo = False

    self.setupRound()
    
    while self.rodada != len(self.tema):
      if self.roundDuration() > 10:
        self.send(f'OO jogador {self.owner} nao preencheu a tempo, trocando de mestre')
        self.setupRound()

    self.broadcastInfo()

    currentTema = self.tema[self.rodada - 1]

    tema = currentTema['tema']
    dica = currentTema['dica']
    resposta = currentTema['resposta']

    print(f'RODADA [{self.rodada}] -> {tema} - {dica} - {resposta}')

    showOrder = random.shuffle(list(range(len(resposta))))
    sent = 0

    self.setStartRound()
    self.roundAtivo = True
    self.send(f't{self.calcTempoRestante()}')
    while sent != 12:
      self.respostaCensurada = resposta #self.getRespostaCensurada(resposta, showOrder)
      self.sendTema()
      sent += 1
      time.sleep(5)
      # if len(self.tema[self.rodada - 1]['acertos']) == len(self.clients) - 1:
      #   break

    self.roundAtivo = False

    porcentagemPontos = len(self.tema[self.rodada - 1]['acertos'])/self.tema[self.rodada - 1]['usuariosInicio'] * 180
    porcentagemPontos = 180 if porcentagemPontos > 180 else porcentagemPontos

    dono = self.tema[self.rodada - 1]['dono']

    self.add_ponto(dono, porcentagemPontos)
    self.broadcastInfo()
    acertos = len(self.tema[self.rodada - 1]['acertos'])
    self.send(f'a{acertos}')
    print('RODADA ACABOU')

  
  def runLobby(self):
    while True:
      if len(self.clients) < 2:
        self.lobbyStarted = time.time()
        continue
      #TODO: ARRUMAR TEMPO
      if time.time() - self.lobbyStarted < 7.5:
        continue
      else:
        self.started = True
        break

    print('JOGO COMECOU')      
    self.send('G')
    self.broadcastInfo()
    self.round()