from django.urls import path
from . import views

from django.urls import include, path
from . import views
from RideEase.Controller import authview
urlpatterns = [
    path('index/', views.index, name='index'),
    path('bookings/<int:user_id>/<int:user_id2>/', views.booking_list, name='booking_list'),
    path('pickup-locations/', views.pickup_locations, name='pickup_locations'),
    path('driver-details/<int:driver_id>/', views.driver_details, name='driver_details'),
    path('inactive-drivers/', views.inactive_drivers, name='inactive_drivers'),
    path('total-distance/', views.olap1, name='olap1'),
    path('total-retrieve/', views.olap2, name='olap2'),
    path('total-retrieve-om/', views.olap3, name='olap3'),
    path('total-retrieve-tuhitu/', views.olap4, name='olap4'),
    path('rideease1/', views.rideease1, name='rideease1'),
    path('rideease2/', views.rideease2, name='rideease2'),
    path('useer-details/<int:user_id>/', views.user_details, name='user_details'),
    path('register/',authview.register,name="register"),
    path('',authview.loginpage, name="loginpage"),
    path('homepage/<int:user_id>/',views.homepage,name="home"),
    path('confirmation/<int:user_id>/<int:distance>/<str:ride_type>/<str:pickup>/<str:dropoff>/', views.confirmation, name='confirmation'),
    path('confirmed/<int:user_id>/<int:distance>/<str:ride_type>/<int:driver_id>/<str:pickup>/<str:dropoff>/', views.confirmed, name='confirmed'),
    path('inactivate/<int:driver_id>/', views.inactivate, name='inactivate'),
    path('activate/<int:driver_id>/', views.activate, name='activate'),
    path('create_booking/<int:user_id>/<int:driver_id>/<str:pickup>/<str:dropoff>/', views.create_booking, name='create_booking'),
    # path('',authview.Si)
# Up,name=''
]