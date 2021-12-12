#!/usr/bin/env python3

import socket, threading

HOST = '127.0.0.1'
PORT = 1338

def send(s):
  while True:
    send = input()
    if not send:
      break
    s.sendall(send.encode())

def receive(s):
  while True:
    data = s.recv(1024)
    if not data:
      break
    print('IN:', data.decode())

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
  s.connect((HOST, PORT))
  threading.Thread(target=receive, args=(s,)).start()
  send(s)