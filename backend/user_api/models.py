from django.db import models
from django.contrib.auth.base_user import BaseUserManager
from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin

class AppUserManager(BaseUserManager):
	def create_user(self, username, email, password=None, **extra_fields):
		if not email:
			raise ValueError('An email is required.')
		if not password:
			raise ValueError('A password is required.')
		email = self.normalize_email(email)
		user = self.model(username=username, email=email, **extra_fields)
		user.set_password(password)
		user.save()
		return user
	def create_superuser(self, username, email, password=None, **extra_fields):
		extra_fields.setdefault('is_staff', True)
		extra_fields.setdefault('is_superuser', True)
		
		if not email:
			raise ValueError('An email is required.')
		if not password:
			raise ValueError('A password is required.')
		user = self.create_user(username, email, password, **extra_fields)
		user.is_superuser = True
		user.save()
		return user


class AppUser(AbstractBaseUser, PermissionsMixin):
	user_id = models.AutoField(primary_key=True)
	email = models.EmailField(max_length=50, unique=True)
	username = models.CharField(max_length=50)
	is_active = models.BooleanField(default=True)
	is_staff = models.BooleanField(default=False)
	date_joined = models.DateTimeField(auto_now_add=True)

	USERNAME_FIELD = 'email'
	REQUIRED_FIELDS = ['username']
	objects = AppUserManager()
	def __str__(self):
		return self.username
	
class Category(models.Model):
	id = models.AutoField(primary_key=True)
	name = models.CharField(max_length=100)

class Menu(models.Model):
	id = models.AutoField(primary_key=True)
	name = models.CharField(max_length=100)
	description = models.TextField()
	category = models.ForeignKey(Category, on_delete=models.CASCADE)
	price = models.DecimalField(max_digits=10, decimal_places=2)
	picture_url = models.URLField()

class DiningTable(models.Model):
	id = models.AutoField(primary_key=True)
	capacity = models.IntegerField()
	location = models.CharField(max_length=100)

class Order(models.Model):
	id = models.AutoField(primary_key=True)
	menu = models.ForeignKey(Menu, on_delete=models.CASCADE)
	quantity = models.IntegerField()
	table = models.ForeignKey(DiningTable, on_delete=models.CASCADE)
	done_flag = models.BooleanField(default=False)
	archive_flag = models.BooleanField(default=False)