from .models import Animals, AnimalTypes, Types
from rest_framework.serializers import ModelSerializer


class AnimalsSerializer(ModelSerializer):
    class Meta:
        model = Animals
        fields = '__all__'

class TypesSerializer(ModelSerializer):
    class Meta:
        model = Types
        fields = '__all__'

class AnimalTypesSerializer(ModelSerializer):
    class Meta:
        model = AnimalTypes
        fields = '__all__'