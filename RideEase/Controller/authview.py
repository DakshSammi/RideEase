from django.shortcuts import redirect,render,HttpResponse
from django.contrib import messages
from RideEase.forms import CustomUserForm
from RideEase.Controller import authview
from django.contrib.auth.models import User
import mysql.connector
from django.shortcuts import render
from RideEase.models import *
from django.http import JsonResponse
from django.db.models import Count
from django.http import HttpResponse
from django.db import transaction
from django.db import connection

# Create your views here.

from RideEase.models import Driver
def register(request):
    with connection.cursor() as cursor:
        cursor.execute("""
        INSERT INTO Users (fname, E_mail, UserPassword) VALUES ('%s', '%s', '%s')
        ON DUPLICATE KEY UPDATE fname='%s', E_mail='%s', UserPassword='%s
        Order by User_id desc limit 1;
        """ % ('test', 'test', 'test'))
    return render(request, 'RideEase/auth/register.html')

@transaction.atomic
def loginpage(request):
    user = Users.objects.get(user_id=1)
    return render(request, 'RideEase/auth/login.html', {'user': user})

# def SignUp(request):