import smtplib
from email.mime.text import MIMEText

def enviar_correo(asunto, mensaje):
    correo_emisor = '!!!C_EMISOR!!!'
    correo_receptor = '!!!C_RECEPTOR!!!'
    contraseña = '!!!PASSWORD!!!'
    # Configuración del servidor SMTP
    smtp_server = 'smtp.outlook.com'
    smtp_port = 587

    # Creación del mensaje
    mensaje_email = MIMEText(mensaje)
    mensaje_email['Subject'] = asunto
    mensaje_email['From'] = correo_emisor
    mensaje_email['To'] = correo_receptor

    # Configuración de la conexión SMTP
    server = smtplib.SMTP(smtp_server, smtp_port)
    server.starttls()
    server.login(correo_emisor, contraseña)

    # Envío del correo
    server.send_message(mensaje_email)
    server.quit()
