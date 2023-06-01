from datos import enviar_correo
import smtplib
from email.mime.text import MIMEText
import os
import subprocess

user = subprocess.run("who -m am i | awk '{print $1}'", shell=True, capture_output=True, text=True)
usuario = user.stdout.strip()
ip = subprocess.run("who -m am i | awk '{print $5}'", shell=True, capture_output=True, text=True)
direccion_ip = ip.stdout.strip()

# Ejemplo de uso
asunto = 'Inicio de sesión por SSH'
mensaje = "El usuario " + usuario + "@" + direccion_ip + " ha iniciado sesión "


enviar_correo(asunto, mensaje)
