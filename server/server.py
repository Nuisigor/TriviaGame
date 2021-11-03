#!/usr/bin/env python3

from os import name
import socket, threading
from datetime import datetime

HOST = '127.0.0.1'
PORT = 1337

clientNames = []

def getDate():
  now = datetime.now()
  return now.strftime("%d/%m/%Y %H:%M:%S")

def handleConnection(conn, addr):
  global clientNames
  print(f'[{getDate()}] Connected by {addr}')
  with conn:
    name = conn.recv(1024).decode()
    if name in clientNames:
      conn.close()
      return
    print(f'[{getDate()}] {addr} set name as {name}')
    clientNames.append(name)

    while True:
      data = conn.recv(1024)
      if not data:
        break

      print(f'[{getDate()}] {name}: {data.decode()}')
      conn.sendall(data)

  clientNames.pop(clientNames.index(name))
  print(f'[{getDate()}] {name} disconnected')

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
  s.bind((HOST, PORT))
  s.listen()
  while True:
    conn, addr = s.accept()
    threading.Thread(target=handleConnection, args=(conn, addr)).start()
