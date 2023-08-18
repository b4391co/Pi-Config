
#!/usr/bin/env python

import requests
import os
from config import TOKEN, CHAT_ID
import subprocess

user = subprocess.run("who -m am i | awk '{print $1}'", shell=True, capture_output=True, text=True)
usuario = user.stdout.strip()
ip = subprocess.run("who -m am i | awk '{print $6}'", shell=True, capture_output=True, text=True)
direccion_ip = ip.stdout.strip()
direccion_ip_sin_parentesis = direccion_ip.replace("(", "").replace(")", "")

def send_telegram_message(message):
    # Reemplaza 'TU_TOKEN' y 'TU_ID_DE_CHAT' con tus valores reales
    url = f'https://api.telegram.org/bot{TOKEN}/sendMessage'
    data = {'chat_id': CHAT_ID, 'text': message}
    response = requests.post(url, data=data)

# Llama a la función para enviar el mensaje
mensaje = f"⚠️⚠️⚠️\nROOT\n El usuario {usuario}@{direccion_ip_sin_parentesis} ha iniciado sesion root"

send_telegram_message(mensaje)
