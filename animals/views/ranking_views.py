from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view
from django.db import connection
import math
from dotenv import load_dotenv

load_dotenv()

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