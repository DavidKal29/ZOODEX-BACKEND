from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view
from django.db import connection


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
def getDietAnimals(request,name):
    try:
        with connection.cursor() as cursor:

            name = name.capitalize()

            query = '''
                SELECT a.id, a.name, c.name, sc.name, a.image, t.name, t.color
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
            '''
            cursor.execute(query,[name])

            rows = cursor.fetchall()

            if len(rows) == 0:
                return Response({'error':'Esa dieta no existe o está mal escrita'})

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

    

