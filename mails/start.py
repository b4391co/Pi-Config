from datos import enviar_correo
import smtplib
from email.mime.text import MIMEText
import os
import subprocess
import time
from datetime import datetime

# Obtener la fecha y hora actual
fecha = datetime.now()
fecha_hora = fecha.strftime("%Y-%m-%d %H:%M:%S")

# Ejemplo de uso
asunto = 'Raspberry Iniciada'
mensaje = 'Raspberry Iniciada a: ' + fecha_hora

enviar_correo(asunto, mensaje)
