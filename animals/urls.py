from django.urls import path
from . import views

urlpatterns = [
    path('getRandomAnimals/', views.getRandomAnimals, name='getRandomAnimals'),
    path('getTop5Rankings', views.getTop5Rankings, name='getTop5Rankings'),
    path('getCategories/',views.getCategories,name='getCategories')
]
