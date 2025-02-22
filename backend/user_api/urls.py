from django.urls import path, include
from rest_framework.routers import DefaultRouter
from . import views

# Create a router and register our viewsets with it
router = DefaultRouter()
router.register(r'categories', views.CategoryViewSet)
router.register(r'menus', views.MenuViewSet)
router.register(r'dining-tables', views.DiningTableViewSet)
router.register(r'orders', views.OrderViewSet)
router.register(r'invoices', views.InvoiceViewSet)

urlpatterns = [
    path('', include(router.urls)),
	path('register', views.UserRegister.as_view(), name='register'),
	path('login', views.UserLogin.as_view(), name='login'),
	path('user', views.UserView.as_view(), name='user'),
]