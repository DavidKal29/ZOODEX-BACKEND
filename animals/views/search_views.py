from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view
from django.db import connection
import math
from dotenv import load_dotenv

load_dotenv()

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