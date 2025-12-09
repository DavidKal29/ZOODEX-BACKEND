from utils.Brevo import api_instance
import sib_api_v3_sdk
from sib_api_v3_sdk.rest import ApiException
from dotenv import load_dotenv
import os

load_dotenv()

class MailSender:

    #Método estático para enviar los mensajes
    @staticmethod
    def _send_email(to_email, subject, html):
        sender={"name": "ZooDex", "email": os.getenv('CORREO')}
        to=[{"email": to_email}]
        send_smtp_email = sib_api_v3_sdk.SendSmtpEmail(
            to=to,
            html_content=html,
            sender=sender,
            subject=subject
        )

        try:
            api_instance.send_transac_email(send_smtp_email)
            print("Correo enviado correctamente a {}".format(to_email))
        except ApiException as e:
            print("Error al enviar correo:", e)


    #Metodo para resetear la contraseña
    @classmethod
    def reset_password_message(cls,email,token):

        #El asunto
        asunto='Recuperación Contraseña'

        #Mensaje de recuperación
        html='''
            <p>🔧 Para recuperar tu contraseña, accede al siguiente enlace👇</p>
            <a href="{}/changePassword/{}">🔁 Reestablecer Contraseña</a>
        '''.format(os.getenv('FRONTEND_URL'),token)

        MailSender._send_email(email,asunto,html)
    
    