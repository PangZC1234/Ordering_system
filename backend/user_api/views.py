from django.contrib.auth import get_user_model, login, logout
#from rest_framework.authentication import SessionAuthentication
from rest_framework.views import APIView
from rest_framework.response import Response
from .serializers import UserRegisterSerializer, UserLoginSerializer, UserSerializer, CategorySerializer, MenuSerializer, DiningTableSerializer, OrderSerializer, InvoiceSerializer
from rest_framework import permissions, status, viewsets
from .validations import custom_validation, validate_email, validate_password
from .models import Category, Menu, DiningTable, Order, Invoice

from rest_framework.permissions import IsAuthenticated
from .permissions import IsSuperUser
from rest_framework_simplejwt.tokens import RefreshToken

class UserRegister(APIView):
	permission_classes = (permissions.AllowAny,)
	def post(self, request):
		clean_data = custom_validation(request.data)
		serializer = UserRegisterSerializer(data=clean_data)
		if serializer.is_valid(raise_exception=True):
			user = serializer.create(clean_data)
			if user:
				return Response(serializer.data, status=status.HTTP_201_CREATED)
		return Response(status=status.HTTP_400_BAD_REQUEST)


class UserLogin(APIView):
	permission_classes = (permissions.AllowAny,)
	def post(self, request):
		data = request.data
		assert validate_email(data)
		assert validate_password(data)
		serializer = UserLoginSerializer(data=data)
		if serializer.is_valid(raise_exception=True):
			user = serializer.check_user(data)
			login(request, user)
			return Response(serializer.data, status=status.HTTP_200_OK)
		else:
			return Response(status=status.HTTP_400_BAD_REQUEST)


class UserLogout(APIView):
	permission_classes = (permissions.AllowAny,)
	def post(self, request):
		try:
			refresh_token = request.data["refresh_token"]
			token = RefreshToken(refresh_token)
			token.blacklist()
			return Response(status=status.HTTP_205_RESET_CONTENT)
		except Exception as e:
			return Response(status=status.HTTP_400_BAD_REQUEST)


class UserView(APIView):
	permission_classes = (IsAuthenticated,)
	
	def get(self, request):
		serializer = UserSerializer(request.user)
		return Response({'user': serializer.data}, status=status.HTTP_200_OK)
	
class CategoryViewSet(viewsets.ModelViewSet):
	permission_classes = (IsAuthenticated, IsSuperUser)
	queryset = Category.objects.all()
	serializer_class = CategorySerializer

class MenuViewSet(viewsets.ModelViewSet):
	permission_classes = (IsAuthenticated,)
	queryset = Menu.objects.all()
	serializer_class = MenuSerializer

class DiningTableViewSet(viewsets.ModelViewSet):
	permission_classes = (IsAuthenticated, IsSuperUser)
	queryset = DiningTable.objects.all()
	serializer_class = DiningTableSerializer

class OrderViewSet(viewsets.ModelViewSet):
	permission_classes = (IsAuthenticated,)
	queryset = Order.objects.all()
	serializer_class = OrderSerializer

class InvoiceViewSet(viewsets.ModelViewSet):
	permission_classes = (IsAuthenticated,)
	queryset = Invoice.objects.all()
	serializer_class = InvoiceSerializer