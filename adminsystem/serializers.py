from rest_framework import serializers
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
    



class EditAnimalSerializer(serializers.Serializer):
    
    name = serializers.CharField(
        min_length=2,
        max_length=30,
        required=True,
        error_messages={
            'max_length': 'Máximo 30 caracteres en el nombre',
            'min_length': 'Mínimo 2 caracteres en el nombre',
            'required': 'El nombre es obligatorio',
            'blank': 'El nombre no puede estar en blanco',
        }
    )

    description = serializers.CharField(
        min_length=10,
        max_length=1000,
        required=True,
        error_messages={
            'max_length': 'Máximo 1000 caracteres en la descripción',
            'min_length': 'Mínimo 10 caracteres en la descripción',
            'required': 'La descripción es obligatoria',
            'blank': 'La descripción no puede estar en blanco',
        }
    )

    subcategory = serializers.IntegerField(
        min_value=1,
        required=True,
        error_messages={
            'required': 'Debes seleccionar una subcategoría',
            'invalid': 'Subcategoría inválida',
        }
    )
    
    type = serializers.IntegerField(
        min_value=1,
        required=True,
        error_messages={
            'required': 'Debes seleccionar un tipo',
            'invalid': 'Tipo inválido',
        }
    )
    
    diet = serializers.IntegerField(
        min_value=1,
        required=True,
        error_messages={
            'required': 'Debes seleccionar una dieta',
            'invalid': 'Dieta inválida',
        }
    )

    weight = serializers.DecimalField(
        max_digits=8,
        decimal_places=2,
        min_value=0.01,
        max_value=200000,
        required=True,
        error_messages={
            'max_digits': 'El peso no puede tener mas de 8 digitos',
            'max_decimal_places': 'El peso solo puede tener 2 decimales',
            'required': 'El peso es obligatorio',
            'min_value': 'El peso no puede ser menor a 0.01 kg',
            'max_value': 'El peso no puede ser mayor a 200000 kg',
        }
    )

    height = serializers.DecimalField(
        max_digits=5,
        decimal_places=2,
        min_value=0.01,
        max_value=30,
        required=True,
        error_messages={
            'max_digits': 'La altura no puede tener mas de 5 digitos',
            'max_decimal_places': 'La altura solo puede tener 2 decimales',
            'required': 'La altura es obligatoria',
            'min_value': 'La altura no puede ser menor a 0.01 m',
            'max_value': 'La altura no puede ser mayor a 30 m'
        }
    )

    speed = serializers.DecimalField(
        max_digits=5,
        decimal_places=2,
        min_value=0.01,
        max_value=400,
        required=True,
        error_messages={
            'max_digits': 'La velocidad no puede tener mas de 5 digitos',
            'max_decimal_places': 'La velocidad solo puede tener 2 decimales',
            'required': 'La velocidad es obligatoria',
            'min_value': 'La velocidad no puede ser menor a 0.01 km/h',
            'max_value': 'La velocidad no puede ser mayor a 400 km/h'
        }
    )

    danger = serializers.IntegerField(
        min_value=1,
        max_value=100,
        required=True,
        error_messages={
            'required': 'El nivel de peligro es obligatorio',
            'min_value': 'El nivel de peligro no puede ser menor a 1',
            'max_value': 'El nivel de peligro no puede ser mayor a 100'
        }
    )

    longevity = serializers.IntegerField(
        min_value=1,
        max_value=500,
        required=True,
        error_messages={
            'required': 'La longevidad es obligatoria',
            'min_value': 'La longevidad no puede ser menor a 1',
            'max_value': 'La longevidad no puede ser mayor a 500'
        }
    )

    inteligence = serializers.IntegerField(
        min_value=1,
        max_value=100,
        required=True,
        error_messages={
            'required': 'La inteligencia es obligatoria',
            'min_value': 'La inteligencia no puede ser menor a 1',
            'max_value': 'La inteligencia no puede ser mayor a 100'
        }
    )
    
    
    #Sanitizar los datos 
    def validate(self, data):
        for key, value in data.items():
            if isinstance(value, str):
                data[key] = sanitize_input(value)

        return data


