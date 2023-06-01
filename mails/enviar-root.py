from datos import enviar_correo
import smtplib
from email.mime.text import MIMEText
import os
import subprocess

user = subprocess.run("who -m am i | awk '{print $1}'", shell=True, capture_output=True, text=True)
usuario = user.stdout.strip()
ip = subprocess.run("who -m am i | awk '{print $5}'", shell=True, capture_output=True, text=True)
direccion_ip = ip.stdout.strip()
log = subprocess.run("cat /var/log/auth.log | grep su | tail -n 10", shell=True, capture_output=True, text=True)
logs = log.stdout.strip()


# Ejemplo de uso
asunto = 'Inicio de sesión como ROOT'
mensaje = "El usuario " + usuario + "@" + direccion_ip + " ha iniciado sesión en SSH anteriormente" + "\n\n\n" + logs

enviar_correo(asunto, mensaje)
