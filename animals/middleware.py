from django.http import JsonResponse
import jwt
from jwt.exceptions import InvalidTokenError,ExpiredSignatureError
from dotenv import load_dotenv
import os
load_dotenv()

class AdminMiddleware:
    def __init__(self,get_response):
        self.get_response = get_response

    def __call__(self,request):
        rutas_protegidas = [
            '/dashboard/',
            '/logout/',
            '/editProfile/'
        ]

        ruta_protegida = False

        for ruta in rutas_protegidas:
            if ruta in request.path:
                ruta_protegida = True


        if ruta_protegida:

            token = request.COOKIES.get('token')

            if not token:
                return JsonResponse({'error':'EL token no ha sido encontrado'},status=401)

            try:
                decoded = jwt.decode(token,os.getenv('JWT_SECRET_KEY'),algorithms=['HS256'])

                request.user_id = decoded['id']           
            
            except InvalidTokenError:
                return JsonResponse({'error':'Token erroneo'},status=401)
            
            except ExpiredSignatureError:
                return JsonResponse({'error':'Token expirado'},status=401)
    
        return self.get_response(request)
            




