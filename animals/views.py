from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view
from django.db import connection


@api_view(['GET'])
def getRandomAnimals(request):
    try:
        with connection.cursor() as cursor:
            query = '''
                SELECT a.id, a.name, a.height, a.weight, a.image, t.name, t.color
                FROM animals as a
                INNER JOIN animal_types as at
                ON a.id = at.id_animal
                INNER JOIN types as t
                ON at.id_type = t.id
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
                    'height':row[2],
                    'weight':row[3],
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
def getCategories(request):
    try:
        with connection.cursor() as cursor:
            query = 'SELECT * FROM categories'

            cursor.execute(query)

            rows = cursor.fetchall()
            categories = []

            for row in rows:
                categories.append({
                    'id':row[0],
                    'name':row[1],
                    'image':row[2],
                    'color':row[3]
                })

            return Response({'success':'Categorias obtenidas con éxito','categories':categories})   
    
    except Exception as err:
        print(err)
        return Response({'error':'Error al obtener los rankings'}) 
    
    

