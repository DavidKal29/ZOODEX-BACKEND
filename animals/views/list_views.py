from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view
from django.db import connection
import math
from dotenv import load_dotenv

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
            return Response({'error':'El numero de pagina es mayor a las paginas permitidas'},status=400)
            
        return Response({
            'success':'Animales obtenidos con éxito',
            'animals':animals,
            'total':total,
            'total_pages':total_pages
        },status=200)  
    
    except Exception as err:
        print(err)
        return Response({'error':'Error al obtener los animales'},status=500)  

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

        return Response({'success':'Animales obtenidos con éxito','animals':animals},status=200)  
    
    except Exception as err:
        print(err)
        return Response({'error':'Error al obtener los animales'},status=500)  
