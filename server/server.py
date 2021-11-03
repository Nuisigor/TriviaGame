#!/usr/bin/env python3

from os import name
import socket, threading
from datetime import datetime
from Server import Server

PORT = 1337

Server(PORT)
