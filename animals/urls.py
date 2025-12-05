from django.urls import path
from . import views

urlpatterns = [
    path('getAllAnimals/', views.getAllAnimals, name='getAllAnimals'),
    path('getRandomAnimals/', views.getRandomAnimals, name='getRandomAnimals'),
    path('getTop5Rankings', views.getTop5Rankings, name='getTop5Rankings'),
    path('getFullRanking/<str:name>', views.getFullRanking, name='getFullRanking'),
    path('getAllFilters/',views.getAllFilters,name='getAllFilters'),
    path('getSubCategories/<str:name>',views.getSubCategories,name='getSubCategories'),
    path('getSubcategoryAnimals/<str:name>',views.getSubcategoryAnimals,name='getSubcategoryAnimals'),
    path('getDietAnimals/<str:name>',views.getDietAnimals,name='getDietAnimals'),
    path('getTypeAnimals/<str:name>',views.getTypeAnimals,name='getTypeAnimals'),
    path('getAnimal/<str:name>', views.getAnimal, name='getAnimal'),
    path('getSearchAnimals/', views.getSearchAnimals, name='getSearchAnimals'),
]
