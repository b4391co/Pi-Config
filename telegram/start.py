#!/usr/bin/env python

import requests
import os
from config import TOKEN, CHAT_ID
import subprocess
import time
from datetime import datetime

# Obtener la fecha y hora actual
fecha = datetime.now()
fecha_hora = fecha.strftime("%Y-%m-%d %H:%M:%S")


def send_telegram_message(message):
    # Reemplaza 'TU_TOKEN' y 'TU_ID_DE_CHAT' con tus valores reales
    url = f'https://api.telegram.org/bot{TOKEN}/sendMessage'
    data = {'chat_id': CHAT_ID, 'text': message}
    response = requests.post(url, data=data)

# Llama a la función para enviar el mensaje
mensaje = f"Raspberry iniciada a las {fecha_hora}"
send_telegram_message(mensaje)