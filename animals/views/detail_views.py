from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view
from django.db import connection
import math
from dotenv import load_dotenv

load_dotenv()

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



 
