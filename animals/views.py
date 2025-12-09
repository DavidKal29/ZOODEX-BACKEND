from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view
from django.db import connection
import math
from django.contrib.auth.hashers import make_password,check_password
import jwt
from jwt.exceptions import ExpiredSignatureError, InvalidTokenError
from datetime import datetime, timedelta
from dotenv import load_dotenv
import os
from .serializers import EditProfileSerializer, LoginSerializer, ForgotPasswordSerializer, ChangePasswordSerializer
from utils.MailSender import MailSender

load_dotenv()

@api_view(['GET'])
def getAllAnimals(request,page):
    try:
        page = int(page)

        with connection.cursor() as cursor:
            query = '''
                SELECT COUNT(*) OVER(),
                a.id, a.name, c.name, sc.name, a.image, t.name, t.color
                FROM animals as a
                INNER JOIN animal_types as at
                ON a.id = at.id_animal
                INNER JOIN types as t
                ON at.id_type = t.id
                INNER JOIN subcategories as sc
                ON a.id_subcategory = sc.id
                INNER JOIN categories as c
                ON sc.id_category = c.id
                ORDER BY a.id
                LIMIT 30
                OFFSET %s
            '''

            offset = 30 * (page - 1)
            cursor.execute(query,[offset])

            rows = cursor.fetchall()

            animals = []
            total = 0
            for row in rows:
                total = row[0]
                animals.append({
                    'id':row[1],
                    'name':row[2],
                    'category':row[3],
                    'subcategory':row[4],
                    'image':row[5],
                    'type':row[6],
                    'color':row[7]
                })

        total_pages = math.ceil(total/30)

        if page > total_pages:
            return Response({'error':'El numero de pagina es mayor a las paginas permitidas'})
            
        return Response({
            'success':'Animales obtenidos con éxito',
            'animals':animals,
            'total':total,
            'total_pages':total_pages
        })  
    
    except Exception as err:
        print(err)
        return Response({'error':'Error al obtener los animales'})  

@api_view(['GET'])
def getRandomAnimals(request):
    try:
        with connection.cursor() as cursor:
            query = '''
                SELECT a.id, a.name, c.name, sc.name, a.image, t.name, t.color
                FROM animals as a
                INNER JOIN animal_types as at
                ON a.id = at.id_animal
                INNER JOIN types as t
                ON at.id_type = t.id
                INNER JOIN subcategories as sc
                ON a.id_subcategory = sc.id
                INNER JOIN categories as c
                ON sc.id_category = c.id
                ORDER BY RAND()
                LIMIT 8    
            '''
            cursor.execute(query)

            rows = cursor.fetchall()

            animals = []
            for row in rows:
                animals.append({
                    'id':row[0],
                    'name':row[1],
                    'category':row[2],
                    'subcategory':row[3],
                    'image':row[4],
                    'type':row[5],
                    'color':row[6]
                })

        return Response({'success':'Animales obtenidos con éxito','animals':animals})  
    
    except Exception as err:
        print(err)
        return Response({'error':'Error al obtener los animales'})  



@api_view(['GET'])
def getTop5Rankings(request):
    try:
        with connection.cursor() as cursor:

            features = ['weight','height','speed','longevity','danger','inteligence']
            titles = ['Más Pesados','Más Altos','Más Rapidos','Más Longevos','Más Peligrosos','Más Inteligentes']

            rankings = {}

            for i in range(len(features)):
                query = '''
                    SELECT a.id, a.name, a.{}, a.image, sc.name as subcategory, c.name as category
                    FROM animals as a
                    INNER JOIN subcategories as sc
                    ON a.id_subcategory = sc.id
                    INNER JOIN categories as c
                    ON sc.id_category = c.id
                    ORDER BY {} DESC
                    LIMIT 5 
                '''.format(features[i],features[i])
                
                cursor.execute(query)
            
                rows = cursor.fetchall()

                animals = []
                
                for row in rows:
                    animals.append({
                        'id':row[0],
                        'name':row[1],
                        features[i]:row[2],
                        'image':row[3],
                        'subcategory':row[4],
                        'category':row[5]
                })
                    
                rankings[titles[i]] = animals

        return Response({'success':'Rankings obtenidos con éxito','rankings':rankings})  
    
    except Exception as err:
        print(err)
        return Response({'error':'Error al obtener los rankings'}) 
    
@api_view(['GET'])
def getFullRanking(request,name,page):
    try:
        
        page = int(page)

        with connection.cursor() as cursor:

            features = ['weight','height','speed','longevity','danger','inteligence']
            titles = ['Más Pesados','Más Altos','Más Rapidos','Más Longevos','Más Peligrosos','Más Inteligentes']

            if name not in titles:
                return Response({'error':'El ranking que intentas buscar no existe'})
            
            index = titles.index(name)

            feature = features[index]

            query = '''
                SELECT COUNT(*) OVER(), a.{},a.id, a.name, c.name, sc.name, a.image, t.name, t.color
                FROM animals as a
                INNER JOIN animal_types as at
                ON a.id = at.id_animal
                INNER JOIN types as t
                ON at.id_type = t.id
                INNER JOIN subcategories as sc
                ON a.id_subcategory = sc.id
                INNER JOIN categories as c
                ON sc.id_category = c.id
                ORDER BY {} DESC
                LIMIT 30
                OFFSET %s
            '''.format(feature,feature)
                
            offset = 30 * (page - 1)
            cursor.execute(query,[offset])
            
            rows = cursor.fetchall()

            ranking = []
            total = 0
                
            for row in rows:
                total = row[0]
                ranking.append({
                    feature:row[1],
                    'id':row[2],
                    'name':row[3],
                    'category':row[4],
                    'subcategory':row[5],
                    'image':row[6],
                    'type':row[7],
                    'color':row[8],
                })
        
        total_pages = math.ceil(total/30)

        if page > total_pages:
            return Response({'error':'El numero de pagina es mayor a las paginas permitidas'})

        return Response({
            'success':'Ranking obtenido con éxito',
            'ranking':ranking,
            'total':total,
            'total_pages':total_pages
        })    
    
    except Exception as err:
        print(err)
        return Response({'error':'Error al obtener el ranking'}) 


@api_view(['GET'])
def getAllFilters(request):
    try:
        with connection.cursor() as cursor:

            #Obtenemos las Categorias primero
            query = 'SELECT * FROM categories'

            cursor.execute(query)

            rows = cursor.fetchall()
            categories = []

            if len(rows) == 0:
                return Response({'error':'No se han encontrado las categorias'}) 

            for row in rows:
                categories.append({
                    'id':row[0],
                    'name':row[1],
                    'image':row[2],
                    'color':row[3]
                })
            

            #Obtenemos ahora las dietas
            query = 'SELECT * FROM diets'

            cursor.execute(query)

            rows = cursor.fetchall()
            diets = []

            if len(rows) == 0:
                return Response({'error':'No se han encontrado las dietas'}) 

            for row in rows:
                diets.append({
                    'id':row[0],
                    'name':row[1],
                    'color':row[2],
                    'description':row[3]
                })


            #Obtenemos los tipos
            query = 'SELECT * FROM types'

            cursor.execute(query)

            rows = cursor.fetchall()
            types = []

            if len(rows) == 0:
                return Response({'error':'No se han encontrado los tipos'}) 

            for row in rows:
                types.append({
                    'id':row[0],
                    'name':row[1],
                    'color':row[2],
                    'description':row[3]
                })

            return Response({'success':'Datos obtenidos con éxito','categories':categories,'diets':diets, 'types':types})   
    
    except Exception as err:
        print(err)
        return Response({'error':'Error al obtener los datos'}) 

    
@api_view(['GET'])
def getSubCategories(request,name):
    try:
        with connection.cursor() as cursor:
            name = name.upper()

            print(name)

            query = '''
                SELECT sc.* FROM categories as c
                INNER JOIN subcategories as sc
                ON c.id = sc.id_category
                WHERE c.name = %s
            '''

            cursor.execute(query,[name])

            rows = cursor.fetchall()
            subcategories = []

            if len(rows) == 0:
                return Response({'error':'Esa categoria no existe'}) 


            for row in rows:
                subcategories.append({
                    'id':row[0],
                    'name':row[1],
                    'image':row[2],
                    'id_category':row[3],
                    'color':row[4]
                })

            return Response({'success':'Subcategorias obtenidas con éxito','subcategories':subcategories})   
    
    except Exception as err:
        print(err)
        return Response({'error':'Error al obtener las subcategorias'}) 


@api_view(['GET'])
def getSubcategoryAnimals(request,name):
    try:
        with connection.cursor() as cursor:

            name = name.upper()

            query = '''
                SELECT a.id, a.name, c.name, sc.name, a.image, t.name, t.color
                FROM animals as a
                INNER JOIN animal_types as at
                ON a.id = at.id_animal
                INNER JOIN types as t
                ON at.id_type = t.id
                INNER JOIN subcategories as sc
                ON a.id_subcategory = sc.id
                INNER JOIN categories as c
                ON sc.id_category = c.id
                WHERE sc.name = %s 
            '''
            cursor.execute(query,[name])

            rows = cursor.fetchall()

            if len(rows) == 0:
                return Response({'error':'Esa subcategoria no existe o está mal escrita'})

            animals = []
            for row in rows:
                animals.append({
                    'id':row[0],
                    'name':row[1],
                    'category':row[2],
                    'subcategory':row[3],
                    'image':row[4],
                    'type':row[5],
                    'color':row[6]
                })

        return Response({'success':'Animales obtenidos con éxito','animals':animals})  
    
    except Exception as err:
        print(err)
        return Response({'error':'Error al obtener los animales'})  
    
@api_view(['GET'])
def getDietAnimals(request,name,page):
    try:
        page = int(page)
        with connection.cursor() as cursor:

            name = name.capitalize()

            query = '''
                SELECT COUNT(*) OVER(), a.id, a.name, c.name, sc.name, a.image, t.name, t.color
                FROM animals as a
                INNER JOIN animal_types as at
                ON a.id = at.id_animal
                INNER JOIN types as t
                ON at.id_type = t.id
                INNER JOIN diets as d
                ON a.id_diet = d.id
                INNER JOIN subcategories as sc
                ON a.id_subcategory = sc.id
                INNER JOIN categories as c
                ON sc.id_category = c.id
                WHERE d.name = %s
                ORDER BY a.name
                LIMIT 30
                OFFSET %s
            '''
            
            offset = 30 * (page - 1)
            cursor.execute(query, [name, offset])
            rows = cursor.fetchall()

            if len(rows) == 0:
                return Response({'error': 'Esa dieta no existe o está mal escrita'})

            animals = []
            total = 0
            for row in rows:
                total = row[0]
                animals.append({
                    'id': row[1],
                    'name': row[2],
                    'category': row[3],
                    'subcategory': row[4],
                    'image': row[5],
                    'type': row[6],
                    'color': row[7]
                })

        total_pages = math.ceil(total / 30)

        if page > total_pages:
            return Response({'error': 'El numero de pagina es mayor a las paginas permitidas'})

        return Response({
            'success': 'Animales obtenidos con éxito',
            'animals': animals,
            'total': total,
            'total_pages': total_pages
        })

    except Exception as err:
        print(err)
        return Response({'error': 'Error al obtener los animales'})


@api_view(['GET'])
def getTypeAnimals(request,name,page):
    try:
        page = int(page)
        with connection.cursor() as cursor:

            name = name.capitalize()

            query = '''
                SELECT COUNT(*) OVER(), a.id, a.name, c.name, sc.name, a.image, t.name, t.color
                FROM animals as a
                INNER JOIN animal_types as at
                ON a.id = at.id_animal
                INNER JOIN types as t
                ON at.id_type = t.id
                INNER JOIN subcategories as sc
                ON a.id_subcategory = sc.id
                INNER JOIN categories as c
                ON sc.id_category = c.id
                WHERE t.name = %s
                ORDER BY a.name
                LIMIT 30
                OFFSET %s
            '''

            offset = 30 * (page - 1)
            cursor.execute(query, [name, offset])
            rows = cursor.fetchall()

            if len(rows) == 0:
                return Response({'error': 'Ese tipo no existe o está mal escrito'})

            animals = []
            total = 0
            for row in rows:
                total = row[0]
                animals.append({
                    'id': row[1],
                    'name': row[2],
                    'category': row[3],
                    'subcategory': row[4],
                    'image': row[5],
                    'type': row[6],
                    'color': row[7]
                })

        total_pages = math.ceil(total / 30)

        if page > total_pages:
            return Response({'error': 'El numero de pagina es mayor a las paginas permitidas'})

        return Response({
            'success': 'Animales obtenidos con éxito',
            'animals': animals,
            'total': total,
            'total_pages': total_pages
        })

    except Exception as err:
        print(err)
        return Response({'error': 'Error al obtener los animales'})




@api_view(['GET'])
def getAnimal(request,name):
    try:
        with connection.cursor() as cursor:
            query = '''
                SELECT a.id, a.name, a.description, a.inteligence, a.height, a.weight,
                        a.speed, a.danger, a.longevity, a.image,
                        c.name, sc.name, t.name, t.color, d.name
                FROM animals as a
                INNER JOIN animal_types as at
                ON a.id = at.id_animal
                INNER JOIN types as t
                ON at.id_type = t.id
                INNER JOIN subcategories as sc
                ON a.id_subcategory = sc.id
                INNER JOIN categories as c
                ON sc.id_category = c.id
                INNER JOIN diets as d
                ON a.id_diet = d.id
                WHERE a.name = %s   
            '''
            cursor.execute(query,[name])

            row = cursor.fetchone()

            if not row:
                return Response({'error':'Animal no encontrado'})

            animal = {
                'id':row[0],
                'name':row[1],
                'description':row[2],
                'inteligence':row[3],
                'height':row[4],
                'weight':row[5],
                'speed':row[6],
                'danger':row[7],
                'longevity':row[8],
                'image':row[9],
                'category':row[10],
                'subcategory':row[11],
                'type':row[12],
                'color':row[13],
                'diet':row[14]
            }
       

        return Response({'success':'Animal obtenido con éxito','animal':animal})  
    
    except Exception as err:
        print(err)
        return Response({'error':'Error al obtener al animal'})  



@api_view(['POST'])
def getSearchAnimals(request):
    try:
        search = request.data.get('search')

        search = search.strip()

        if search[0].isdigit():
            new_search = ''
            for s in search:
                if s.isdigit():
                    new_search += s
                
                else: 
                    search = new_search
                    break
        else:  
            search = ' '.join(search.split())     

        print(search)
        
        with connection.cursor() as cursor:
            
            query = '''
                SELECT a.id, a.name, c.name, sc.name, a.image, t.name, t.color
                FROM animals as a
                INNER JOIN animal_types as at
                ON a.id = at.id_animal
                INNER JOIN types as t
                ON at.id_type = t.id
                INNER JOIN subcategories as sc
                ON a.id_subcategory = sc.id
                INNER JOIN categories as c
                ON sc.id_category = c.id
                WHERE a.name LIKE %s or a.id = %s
                ORDER BY a.id 
            '''

            try:
                search_id = int(search)
            
            except:
                search_id = -1

            search = '%' + search + '%'

            cursor.execute(query,[search,search_id])

            rows = cursor.fetchall()

            animals = []
            for row in rows:
                animals.append({
                    'id':row[0],
                    'name':row[1],
                    'category':row[2],
                    'subcategory':row[3],
                    'image':row[4],
                    'type':row[5],
                    'color':row[6]
                })

            if len(animals) == 0:
                return Response({'error':'No se han encontrado animales bajo esa búsqueda'})  

        return Response({'success':'Animales obtenidos con éxito','animals':animals})  
    
    except Exception as err:
        print(err)
        return Response({'error':'Error al obtener los animales'})  



@api_view(['POST'])
def login(request):
    try:

        serializer = LoginSerializer(data=request.data)

        if not serializer.is_valid():
            print(serializer.errors)
            first_field = list(serializer.errors.keys())[0]
            first_error = serializer.errors[first_field][0]

            return Response({'error':first_error})   

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

                    response = Response({'success':'Usuario logueado con éxito','userID':user['id']})

                    response.set_cookie('token',token,httponly=True,secure=False,samesite='lax',max_age=36000)

                    return response

                else:
                    return Response({'error':'Contraseña Incorrecta'})

            else:
                return Response({'error':'Email Incorrecto'})
           
    
    except Exception as err:
        print(err)
        return Response({'error':'Error al loguear usuario'})  
    


@api_view(['GET'])
def dashboard(request):
    try:
        with connection.cursor() as cursor:
            query = 'SELECT * FROM users WHERE id = %s'
            cursor.execute(query,[request.user_id])

            row = cursor.fetchone()

            if row:
                user = {
                    'id':row[0],
                    'email':row[1],
                    'username':row[2]
                }

                return Response({'success':'Perfil obtenido','user':user})
            
            else:
                return Response({'error':'No se ha podido encontrar la cuenta'})

    
    except Exception as err:
        print(err)
        return Response({'error':'Error al obtener el usuario'}) 



@api_view(['GET'])
def logout(request):
    try:
        response = Response({'success':'Sesión cerrada con éxito'})
        response.delete_cookie('token')
        return response
    

    except Exception as err:
        print(err)
        return Response({'error':'Error al cerrar la sesion'}) 
    


@api_view(['POST'])
def editProfile(request):
    try:
        serializer = EditProfileSerializer(data=request.data)

        if not serializer.is_valid():
            print(serializer.errors)
            first_field = list(serializer.errors.keys())[0]
            first_error = serializer.errors[first_field][0]

            return Response({'error':first_error})

        email = request.data.get('email')
        username = request.data.get('username')
        password = request.data.get('password')

        with connection.cursor() as cursor:
            
            query = 'SELECT * FROM users WHERE id = %s'

            cursor.execute(query,[request.user_id])

            row = cursor.fetchone()

            if row:
                user = {
                    'id': row[0],
                    'email': row[1],
                    'username': row[2],
                    'password': row[3]
                }

                passwordMatches = check_password(password,user['password'])
                
                if email == user['email'] and username == user['username'] and (not password or passwordMatches):
                    return Response({'error':'No hay cambios que realizar'})

                query = 'UPDATE users SET email = %s, username = %s, password = %s WHERE id = %s'

                if password:
                    newPassword = make_password(password)
                else:
                    newPassword = user['password']

                cursor.execute(query,[email,username,newPassword,user['id']])

                return Response({'success':'Datos cambiados con éxito'})
            
            else:
                return Response({'error':'Usuario no encontrado'})
           
    
    except Exception as err:
        print(err)
        return Response({'error':'Error al editar perfil del usuario'}) 




@api_view(['POST'])
def forgotPassword(request):
    try:

        serializer = ForgotPasswordSerializer(data=request.data)

        if not serializer.is_valid():
            print(serializer.errors)
            first_field = list(serializer.errors.keys())[0]
            first_error = serializer.errors[first_field][0]

            return Response({'error':first_error})   

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

                return Response({'success':'Correo enviado con éxito'})   

            else:
                return Response({'error':'No hay cuentas con ese email'})
           
    
    except Exception as err:
        print(err)
        return Response({'error':'Error al enviar el correo de recuperación'})  
    

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

            return Response({'error':first_error})   

        new_password = request.data.get('new_password')
        confirm_password = request.data.get('confirm_password')

        with connection.cursor() as cursor:
            query = 'SELECT password FROM users WHERE email = %s and token =%s'

            cursor.execute(query,[email,token])

            row = cursor.fetchone()

            if not row:
                return Response({'error':'Token Expirado'})
                
            if new_password != confirm_password:
                return Response({'error':'Las contraseñas no coinciden'})
                
            old_password = row[0]
                
            if check_password(new_password,old_password):
                return Response({'error':'La nueva contraseña no puede ser igual a la anterior'})
            
            hashed_password = make_password(new_password)
                
            query = 'UPDATE users SET password = %s, token = "" WHERE email = %s'
            cursor.execute(query,[hashed_password,email])

            return Response({'success':'Contraseña cambiada con éxito'})

    except ExpiredSignatureError as err:
        return Response({'error':'Este enlace ha expirado, solicite recuperación de nuevo'})
        
    except InvalidTokenError as err:
        return Response({'error':'Este enlace es invalido, solicite recuperación de nuevo'})     
           
    except Exception as err:
        print(err)
        return Response({'error':'Error al cambiar la contraseña'})  
     



@api_view(['GET','POST'])
def editAnimal(request,id):
    try:
        if request.method == 'GET':
            with connection.cursor() as cursor:
                query = '''
                    SELECT a.id, a.name, a.description, a.inteligence, a.height, a.weight,
                            a.speed, a.danger, a.longevity, a.image,
                            c.name, sc.id, t.id, t.color, d.id
                    FROM animals as a
                    INNER JOIN animal_types as at
                    ON a.id = at.id_animal
                    INNER JOIN types as t
                    ON at.id_type = t.id
                    INNER JOIN subcategories as sc
                    ON a.id_subcategory = sc.id
                    INNER JOIN categories as c
                    ON sc.id_category = c.id
                    INNER JOIN diets as d
                    ON a.id_diet = d.id
                    WHERE a.id = %s   
                '''
                cursor.execute(query,[id])

                row = cursor.fetchone()

                if not row:
                    return Response({'error':'Animal no encontrado'})

                animal = {
                    'id':row[0],
                    'name':row[1],
                    'description':row[2],
                    'inteligence':row[3],
                    'height':row[4],
                    'weight':row[5],
                    'speed':row[6],
                    'danger':row[7],
                    'longevity':row[8],
                    'image':row[9],
                    'category':row[10],
                    'subcategory':row[11],
                    'type':row[12],
                    'color':row[13],
                    'diet':row[14]
                }

                metadata = {}
                
                queries = {
                    'subcategories':'SELECT id, name FROM subcategories',
                    'diets':'SELECT id, name FROM diets',
                    'types':'SELECT id, name FROM types'
                }

                for key,query in queries.items():
                    cursor.execute(query)
                    rows = cursor.fetchall()

                    metadata[key] = []

                    for row in rows:
                        metadata[key].append({
                            'id':row[0],
                            'name':row[1]
                        })
                    
            return Response({'success':'Animal obtenido con éxito','animal':animal,'metadata':metadata})  
        
        
        if request.method == 'POST':
            with connection.cursor() as cursor:
                newName = request.data.get('name')
                subcategory = request.data.get('subcategory')
                diet = request.data.get('diet')
                type = request.data.get('type')
                weight = request.data.get('weight')
                height = request.data.get('height')
                inteligence = request.data.get('inteligence')
                danger = request.data.get('danger')
                longevity = request.data.get('longevity')
                speed = request.data.get('speed')
                description = request.data.get('description')

                print(newName,subcategory,diet,weight,height,inteligence,danger,longevity,speed,description,id)


                query = '''
                    UPDATE animals 
                    SET name = %s, id_subcategory = %s, id_diet = %s, 
                    weight = %s, height = %s, inteligence = %s,danger = %s, 
                    longevity = %s, speed = %s, description = %s 
                    WHERE id = %s
                '''

                values=[newName,subcategory,diet,weight,height,inteligence,danger,longevity,speed,description,id]

                cursor.execute(query,values)

                query = 'UPDATE animal_types SET id_type = %s WHERE id_animal = %s'
                cursor.execute(query,[type,id])

            return Response({'success':'Datos enviados con éxito'})  
    
    except Exception as err:
        print(err)
        return Response({'error':'Error al editar al animal'})  
