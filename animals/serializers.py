from rest_framework import serializers
from django.core.validators import RegexValidator
from django.core.exceptions import ValidationError
from django.utils.html import escape
import re


#Escapará los datos
def sanitize_input(value):
    cleaned = ' '.join(value.split()).strip() 
    escaped = escape(cleaned)  

    return escaped

#Validará la contraseña
def validate_password_rules(value):
    if not value:
        return value
    if not re.search(r'[A-Z]', value):
        raise serializers.ValidationError('La contraseña debe tener al menos una letra mayúscula')
    if not re.search(r'[a-z]', value):
        raise serializers.ValidationError('La contraseña debe tener al menos una letra minúscula')
    if not re.search(r'\d', value):
        raise serializers.ValidationError('La contraseña debe tener al menos un número')
    if not re.search(r'[@$!%*?&]', value):
        raise serializers.ValidationError('La contraseña debe tener al menos un caracter especial')
    return value


class LoginSerializer(serializers.Serializer):
    email = serializers.EmailField(
        min_length=10,
        max_length=100,
        required=True,
        error_messages={
            'max_length': 'Máximo 100 caracteres en el email',
            'min_length': 'Mínimo 10 caracteres en el email',
            'required': 'El email es obligatorio',
            'invalid': 'Debes poner un email válido',
            'blank': 'El email no puede estar en blanco',
        }
    )
    
    password = serializers.CharField(
        min_length=8,
        max_length=30,
        required=True,
        error_messages={
            'max_length': 'Máximo 30 caracteres en la contraseña',
            'min_length': 'Mínimo 8 caracteres en la contraseña',
            'blank': 'La contraseña no puede estar en blanco',
        }  
    )

    #Sanitizar los datos 
    def validate(self, data):
        for key, value in data.items():
            if isinstance(value, str):
                data[key] = sanitize_input(value)

        return data


class EditProfileSerializer(serializers.Serializer):
    email = serializers.EmailField(
        min_length=10,
        max_length=100,
        required=True,
        error_messages={
            'max_length': 'Máximo 100 caracteres en el email',
            'min_length': 'Mínimo 10 caracteres en el email',
            'required': 'El email es obligatorio',
            'invalid': 'Debes poner un email válido',
            'blank': 'El email no puede estar en blanco',
        }
    )
    username = serializers.CharField(
        min_length=3,
        max_length=25,
        required=True,
        error_messages={
            'max_length': 'Máximo 25 caracteres en el username',
            'min_length': 'Mínimo 3 caracteres en el username',
            'required': 'El username es obligatorio',
            'blank': 'El username no puede estar en blanco',
        }
    )
    
    
    password = serializers.CharField(
        min_length=8,
        max_length=30,
        required=False,
        allow_blank=True,
        error_messages={
            'max_length': 'Máximo 30 caracteres en la contraseña',
            'min_length': 'Mínimo 8 caracteres en la contraseña'
        }  
    )

    #Validar la contraseña
    def validate_password(self, value):
        return validate_password_rules(value)

    #Sanitizar los datos 
    def validate(self, data):
        for key, value in data.items():
            if isinstance(value, str):
                data[key] = sanitize_input(value)

        return data
    

class ForgotPasswordSerializer(serializers.Serializer):
    email = serializers.EmailField(
        min_length=10,
        max_length=100,
        required=True,
        error_messages={
            'max_length': 'Máximo 100 caracteres en el email',
            'min_length': 'Mínimo 10 caracteres en el email',
            'required': 'El email es obligatorio',
            'invalid': 'Debes poner un email válido',
            'blank': 'El email no puede estar en blanco',
        }
    )

    #Sanitizar los datos 
    def validate(self, data):
        for key, value in data.items():
            if isinstance(value, str):
                data[key] = sanitize_input(value)

        return data


