# Generated by Django 4.1.5 on 2024-06-01 05:20

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('user_api', '0003_remove_appuser_is_staff'),
    ]

    operations = [
        migrations.AddField(
            model_name='appuser',
            name='is_active',
            field=models.BooleanField(default=True),
        ),
        migrations.AddField(
            model_name='appuser',
            name='is_staff',
            field=models.BooleanField(default=False),
        ),
    ]
