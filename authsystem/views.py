from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view
from django.db import connection
from django.contrib.auth.hashers import make_password,check_password
import jwt
from jwt.exceptions import ExpiredSignatureError, InvalidTokenError
from datetime import datetime, timedelta
from dotenv import load_dotenv
import os
from .serializers import LoginSerializer, ForgotPasswordSerializer, ChangePasswordSerializer
from utils.MailSender import MailSender

load_dotenv()


@api_view(['POST'])
def login(request):
    try:

        serializer = LoginSerializer(data=request.data)

        if not serializer.is_valid():
            print(serializer.errors)
            first_field = list(serializer.errors.keys())[0]
            first_error = serializer.errors[first_field][0]

            return Response({'error':first_error},status=400)   

        email = request.data.get('email')
        password = request.data.get('password')

        with connection.cursor() as cursor:
            
            query = 'SELECT id, email, password FROM users WHERE email = %s'

            cursor.execute(query,[email])

            row = cursor.fetchone()

            if row:
                user = {
                    'id': row[0],
                    'email': row[1],
                    'password': row[2]
                }
      
                passwordMatches = check_password(password,user['password'])

                if passwordMatches:
                    payload = {
                        'id':user['id'],
                        'exp':datetime.utcnow() + timedelta(hours=1)
                    }

                    JWT_SECRET_KEY = os.getenv('JWT_SECRET_KEY')
                    
                    
                    token = jwt.encode(payload,JWT_SECRET_KEY,algorithm='HS256')

                    response = Response({'success':'Usuario logueado con éxito','userID':user['id']},status=200)


                    response.set_cookie(
                        'token',
                        token,
                        httponly = (os.getenv('COOKIE_HTTPONLY') == 'True'),
                        secure=(os.getenv('COOKIE_SECURE') == 'True'),
                        samesite=os.getenv('COOKIE_SAMESITE'),
                        max_age=36000,
                        path='/'
                    )

                    return response

                else:
                    return Response({'error':'Contraseña Incorrecta'},status=400)

            else:
                return Response({'error':'Email Incorrecto'},status=400)
           
    
    except Exception as err:
        print(err)
        return Response({'error':'Error al loguear usuario'},status=500)  
    


@api_view(['POST'])
def forgotPassword(request):
    try:

        serializer = ForgotPasswordSerializer(data=request.data)

        if not serializer.is_valid():
            print(serializer.errors)
            first_field = list(serializer.errors.keys())[0]
            first_error = serializer.errors[first_field][0]

            return Response({'error':first_error},status=400)   

        email = request.data.get('email')

        with connection.cursor() as cursor:
            
            query = 'SELECT email FROM users WHERE email = %s'

            cursor.execute(query,[email])

            row = cursor.fetchone()

            if row:

                payload = {
                    'email':email,
                    'exp':datetime.utcnow() + timedelta(minutes=5)
                }

                JWT_SECRET_KEY = os.getenv('JWT_SECRET_KEY')

                token = jwt.encode(payload,JWT_SECRET_KEY,algorithm='HS256')  

                query = 'UPDATE users SET token = %s WHERE email = %s' 

                cursor.execute(query,[token,email])  

                MailSender.reset_password_message(email,token)  

                return Response({'success':'Correo enviado con éxito'},status=200)   

            else:
                return Response({'error':'No hay cuentas con ese email'},status=404)
           
    
    except Exception as err:
        print(err)
        return Response({'error':'Error al enviar el correo de recuperación'},status=500)  
    

@api_view(['POST'])
def changePassword(request,token):
    try:
        JWT_SECRET_KEY = os.getenv('JWT_SECRET_KEY')
        
        decode = jwt.decode(token,JWT_SECRET_KEY,algorithms=['HS256'])

        email = decode['email']

        serializer = ChangePasswordSerializer(data=request.data)

        if not serializer.is_valid():
            print(serializer.errors)
            first_field = list(serializer.errors.keys())[0]
            first_error = serializer.errors[first_field][0]

            return Response({'error':first_error},status=400)   

        new_password = request.data.get('new_password')
        confirm_password = request.data.get('confirm_password')

        with connection.cursor() as cursor:
            query = 'SELECT password FROM users WHERE email = %s and token =%s'

            cursor.execute(query,[email,token])

            row = cursor.fetchone()

            if not row:
                return Response({'error':'Token Expirado'},status=401)
                
            if new_password != confirm_password:
                return Response({'error':'Las contraseñas no coinciden'},status=400)
                
            old_password = row[0]
                
            if check_password(new_password,old_password):
                return Response({'error':'La nueva contraseña no puede ser igual a la anterior'},status=400)
            
            hashed_password = make_password(new_password)
                
            query = 'UPDATE users SET password = %s, token = "" WHERE email = %s'
            cursor.execute(query,[hashed_password,email])

            return Response({'success':'Contraseña cambiada con éxito'},status=200)

    except ExpiredSignatureError as err:
        return Response({'error':'Este enlace ha expirado, solicite recuperación de nuevo'},status=401)
        
    except InvalidTokenError as err:
        return Response({'error':'Este enlace es invalido, solicite recuperación de nuevo'},status=401)     
           
    except Exception as err:
        print(err)
        return Response({'error':'Error al cambiar la contraseña'},status=500)  