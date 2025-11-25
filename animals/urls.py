from django.urls import path
from . import views

urlpatterns = [
    path('getAnimals/', views.getAnimals, name='getAnimals')
]
