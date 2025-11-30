from django.urls import path
from . import views

urlpatterns = [
    path('getRandomAnimals/', views.getRandomAnimals, name='getRandomAnimals'),
    path('getTop5Rankings', views.getTop5Rankings, name='getTop5Rankings'),
    path('getAllFilters/',views.getAllFilters,name='getAllFilters'),
    path('getSubCategories/<str:name>',views.getSubCategories,name='getSubCategories'),
    path('getSubcategoryAnimals/<str:name>',views.getSubcategoryAnimals,name='getSubcategoryAnimals'),
]
