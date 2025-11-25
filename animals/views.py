from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view
from .models import Animals
from .serializer import AnimalsSerializer

# Create your views here.
@api_view(['GET'])
def getAnimals(request):
    animals = Animals.objects.all()
    serializer = AnimalsSerializer(animals,many=True)
    return Response(serializer.data)
    
