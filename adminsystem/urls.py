from django.urls import path
from . import views

urlpatterns =[
    path('dashboard/',views.dashboard,name='dashboard'),
    path('logout/',views.logout,name='logout'),
    path('editProfile/',views.editProfile,name='editProfile'),
    path('editAnimal/<int:id>',views.editAnimal,name='editAnimal'),
]