#!/usr/bin/env python3

from os import name
import socket, threading
from datetime import datetime
from ServerClass import Server

PORT = 1338

Server(PORT)
