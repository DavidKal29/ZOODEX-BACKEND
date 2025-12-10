from django.urls import path
from . import views

urlpatterns = [
    path('login/',views.login,name='login'),
    path('forgotPassword/',views.forgotPassword,name='forgotPassword'),
    path('changePassword/<str:token>',views.changePassword,name='changePassword')
]