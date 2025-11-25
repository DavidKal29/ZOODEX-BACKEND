from .models import Animals
from rest_framework.serializers import ModelSerializer


class AnimalsSerializer(ModelSerializer):
    class Meta:
        model = Animals
        fields = '__all__'