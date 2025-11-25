from django.db import models

# Create your models here.
class Categories(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(unique=True, max_length=255)
    image = models.CharField(max_length=255)

    class Meta:
        managed = False
        db_table = 'categories'


class Subcategories(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(unique=True, max_length=255)
    image = models.CharField(max_length=255)
    id_category = models.ForeignKey(Categories, models.DO_NOTHING, db_column='id_category')

    class Meta:
        managed = False
        db_table = 'subcategories'