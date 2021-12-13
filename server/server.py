#!/usr/bin/env python3

from ServerClass import Server
import sys


if len(sys.argv) != 2:
  print(f'Para rodar o servidor: {sys.argv[0]} PORTASERVIDOR')
else:
  PORT = int(sys.argv[1])
  Server(PORT)