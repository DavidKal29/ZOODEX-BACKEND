from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view
from django.db import connection


@api_view(['GET'])
def getRandomAnimals(request):

    with connection.cursor() as cursor:
        query = '''
            SELECT a.id, a.name, t.name 
            FROM byyaf0imkignvliwwex9.animals as a
            INNER JOIN byyaf0imkignvliwwex9.animal_types as at
            ON a.id = at.id_animal
            INNER JOIN byyaf0imkignvliwwex9.types as t
            ON at.id_type = t.id
            ORDER BY RAND()
            LIMIT 12        
        '''
        cursor.execute(query)

        rows = cursor.fetchall()

        animals = []
        for row in rows:
            animals.append({
                'id':row[0],
                'name':row[1],
                'type':row[2]
            })

    return Response({'success':'Animales obtenido con éxito','animals':animals})  
