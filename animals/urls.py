from django.urls import path
from . import views

urlpatterns = [
    path('getRandomAnimals/', views.getRandomAnimals, name='getRandomAnimals')
]
