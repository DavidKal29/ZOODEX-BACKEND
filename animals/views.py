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

        return Response({'success':'Animales obtenido con éxito','animals':animals})  
    
    except Exception as err:
        print(err)
        return Response({'error':'Error al obtener los animales','animals':animals})  
