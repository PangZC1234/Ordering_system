from django.contrib import admin

# Register your models here.
from .models import AppUser, Category, Menu, DiningTable, Order, Invoice

admin.site.register(AppUser)
admin.site.register(Category)
admin.site.register(Menu)
admin.site.register(DiningTable)
admin.site.register(Order)
admin.site.register(Invoice)