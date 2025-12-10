from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view
from django.db import connection
from django.contrib.auth.hashers import make_password,check_password
from dotenv import load_dotenv
from .serializers import EditAnimalSerializer, EditProfileSerializer

load_dotenv()
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

                return Response({'success':'Perfil obtenido','user':user},status=200)
            
            else:
                return Response({'error':'No se ha podido encontrar la cuenta'},status=404)

    
    except Exception as err:
        print(err)
        return Response({'error':'Error al obtener el usuario'},status=500) 



@api_view(['GET'])
def logout(request):
    try:
        response = Response({'success':'Sesión cerrada con éxito'},status=200)
        response.delete_cookie('token')
        return response
    

    except Exception as err:
        print(err)
        return Response({'error':'Error al cerrar la sesion'},status=500) 
    


@api_view(['POST'])
def editProfile(request):
    try:
        serializer = EditProfileSerializer(data=request.data)

        if not serializer.is_valid():
            print(serializer.errors)
            first_field = list(serializer.errors.keys())[0]
            first_error = serializer.errors[first_field][0]

            return Response({'error':first_error},status=400)

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
                    return Response({'error':'Asegurate que al menos un campo sea distinto'},status=400)

                query = 'UPDATE users SET email = %s, username = %s, password = %s WHERE id = %s'

                if password:
                    newPassword = make_password(password)
                else:
                    newPassword = user['password']

                cursor.execute(query,[email,username,newPassword,user['id']])

                return Response({'success':'Datos cambiados con éxito'},status=200)
            
            else:
                return Response({'error':'Usuario no encontrado'},status=404)
           
    
    except Exception as err:
        print(err)
        return Response({'error':'Error al editar perfil del usuario'},status=500) 


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
                    return Response({'error':'Animal no encontrado'},status=404)

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
                    
            return Response({'success':'Animal obtenido con éxito','animal':animal,'metadata':metadata},status=200)  
        
        
        if request.method == 'POST':
            serializer = EditAnimalSerializer(data=request.data)

            if not serializer.is_valid():
                print(serializer.errors)
                first_field = list(serializer.errors.keys())[0]
                first_error = serializer.errors[first_field][0]

                return Response({'error':first_error},status=400)   



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

            return Response({'success':'Datos enviados con éxito'},status=200)  
    
    except Exception as err:
        print(err)
        return Response({'error':'Error al editar al animal'},status=500) 