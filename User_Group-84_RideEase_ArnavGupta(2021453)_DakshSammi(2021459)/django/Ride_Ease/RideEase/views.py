import mysql.connector
from django.shortcuts import render
from .models import *
from django.http import JsonResponse
from django.db.models import Count
from django.http import HttpResponse
from django.db import transaction

# Create your views here.

from .models import Driver

def index(request):
    # check if a trigger has been executed and display a message
    if 'driver_status_trigger' in request.session:
        driver_id = request.session['driver_status_trigger']
        driver = Driver.objects.get(pk=driver_id)
        message = f"Driver {driver.Driver_Name} status has been set to 'inactive'."
        del request.session['driver_status_trigger']
    elif 'user_trigger' in request.session:
        user_id = request.session['user_trigger']
        user = Users.objects.get(pk=user_id)
        message = f"User {user.User_Name} has been promoted to 'Prime' status."
        del request.session['user_trigger']
    else:
        message = None
    driver = Driver.objects.first()
    context = {'driver': driver, 'message': message}
    return render(request, 'RideEase/index.html', context)

@transaction.atomic
def booking_list(request, user_id, user_id2):
    if user_id > 0:
        bookings = Bookings.objects.filter(userid=user_id).order_by('booking_id')
        user = Users.objects.get(user_id=user_id2)
        context = {'bookings': bookings, 'user': user}
        return render(request, 'RideEase/Bookings.html', context)
    else:
        return JsonResponse({'error': 'Invalid user ID'})

def rideease1(request):
    return render(request, 'RideEase/rideease1.html')

def rideease2(request):
    return render(request, 'RideEase/rideease2.html')

def pickup_locations(request):
    locations = Bookings.objects.values('pickup').annotate(count=Count('pickup')).order_by('-count')[:3]
    data = [{'pickup': location['pickup'], 'count': location['count']} for location in locations]
    return JsonResponse(data, safe=False)

def driver_details(request, driver_id):
    if driver_id > 0:
        driver = Driver.objects.filter(driver_id=driver_id).first()
        context = {'driver': driver}
        return render(request, 'RideEase/driver-details.html', context)
    else:
        return JsonResponse({'error': 'Invalid driver ID'})
    
def inactive_drivers(request):
    drivers = Driver.objects.filter(dr_status='Inactive').values('driver_id', 'fname', 'driver_rating', 'dr_status', 'e_mail').order_by('driver_id')
    data = [{'driver_id': driver['driver_id'], 'fname': driver['fname'], 'driver_rating': driver['driver_rating'], 'dr_status': driver['dr_status'], 'e_mail': driver['e_mail']} for driver in drivers]
    return JsonResponse(data, safe=False)

from django.shortcuts import render
from django.db import connection

def olap1(request):
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT YEAR(Tim) AS Booking_Year, MONTH(Tim) AS Booking_Month, DrivID, SUM(Distance) AS Total_Distance
            FROM DrivesFor D 
            GROUP BY Booking_Year,Booking_Month,DrivID with ROLLUP
            HAVING GROUPING (Booking_Year)=0 AND GROUPING(Booking_Month)=0 AND GROUPING(DrivID)=0;
        """)
        rows = cursor.fetchall()
        data = [{'year': row[0], 'month': row[1], 'drivid': row[2], 'distance': row[3]} for row in rows]
        return JsonResponse(data, safe=False)
    
def olap2(request):
    with connection.cursor() as cursor:
        cursor.execute("""
        SELECT YEAR(Tim) AS Booking_Year, MONTH(Tim) AS Booking_Month, Users.fname, Users.lname
        FROM DrivesFor 
        JOIN Users ON DrivesFor.UsrID = Users.User_ID
        GROUP BY Booking_Year, Booking_Month, Users.fname, Users.lname with ROLLUP
        HAVING GROUPING (Booking_Year)=0 AND GROUPING(Booking_Month)=0 AND GROUPING(Users.fname)=0 AND GROUPING(Users.lname)=0;
        """)
        rows = cursor.fetchall()
        data = [{'year': row[0], 'month': row[1], 'fname': row[2], 'lname': row[3]} for row in rows]
        return JsonResponse(data, safe=False)
    
def olap3(request):
    with connection.cursor() as cursor:
        cursor.execute("""
        SELECT R_type, COUNT(*) AS num_bookings, AVG(Payment_Amount) AS avg_fare
        FROM Ride
        JOIN Payment ON Ride.RideID=Payment.PaymentID 
        GROUP BY R_type with ROLLUP
        HAVING GROUPING (R_type)=0;
        """)
        rows = cursor.fetchall()
        data = [{'type': row[0], 'num_bookings': row[1], 'avg_fare': row[2]} for row in rows]
        return JsonResponse(data, safe=False)
    
def olap4(request):
    with connection.cursor() as cursor:
        cursor.execute("""
        SELECT fname,lname,YEAR(Tim) AS Year,MONTH(Tim) AS Month,Driver_Rating AS Rating
        FROM Driver
        JOIN DrivesFor ON Driver.Driver_ID = DrivesFor.DrivID
        WHERE Driver_Rating>3
        GROUP BY Year,Month,fname,lname,Rating WITH ROLLUP
        HAVING GROUPING(fname) = 0 AND GROUPING(Year) = 0 AND GROUPING(Month) = 0 AND GROUPING(lname) = 0 AND GROUPING(Rating) = 0;
        """)
        rows = cursor.fetchall()
        data = [{'fname': row[0], 'lname': row[1], 'year': row[2], 'month': row[3], 'rating': row[4]} for row in rows]
        return JsonResponse(data, safe=False)

def user_details(request, user_id):
    user = Users.objects.get(user_id=user_id)
    return render(request, 'RideEase/useer-details.html', {'user': user})

# views.py

from django.shortcuts import render, redirect

def homepage(request, user_id):
    user = Users.objects.get(user_id=user_id)
    if request.method == 'POST':
        distance = request.POST.get('distance')
        ride_type = request.POST.get('ride-type')
        pickup = request.POST.get('pick-id')
        dropoff = request.POST.get('drop-id')
        return redirect('confirmation', user_id=user_id, distance=distance, ride_type=ride_type, pickup=pickup, dropoff=dropoff)
    else:
        return render(request, 'RideEase/homepage.html', {'user': user})

def confirmation(request, user_id, distance, ride_type, pickup, dropoff):
    user = Users.objects.get(user_id=user_id)
    with connection.cursor() as cursor:
        cursor.execute("""
        SELECT fname, e_mail, driver_rating, driver_id
        FROM Driver
        WHERE dr_status = 'Active'
        ORDER BY RAND()
        LIMIT 1;
        """)
        rows = cursor.fetchall()
        data = [{'fname': row[0], 'e_mail': row[1], 'driver_rating': row[2], 'driver_id':row[3]} for row in rows]
    context = {'user': user, 'distance': distance, 'ride_type': ride_type, 'driver': data[0], 'pickup': pickup, 'dropoff': dropoff}
    return render(request, 'RideEase/confirmation.html', context)
from django.http import JsonResponse
from .models import Driver, Bookings, Users
from django.db import connection
from django.shortcuts import render

@transaction.atomic
def inactivate(request, driver_id):
    driver = Driver.objects.get(driver_id=driver_id)
    driver.dr_status = 'Inactive'
    driver.save()
    return JsonResponse({'status': 'success'})

def create_booking(request, user_id, driver_id, pickup, dropoff):
    # Find the latest booking id and increment it
    last_booking_id = Bookings.objects.latest('booking_id').booking_id
    booking_id = last_booking_id + 1

    # Create a new booking object
    booking = Bookings(booking_id=booking_id, userid_id=user_id, dri_id=driver_id, pickup=pickup, dropoff=dropoff)
    booking.save()

    return JsonResponse({'status': 'success'})

@transaction.atomic
def activate(request, driver_id):
    driver = Driver.objects.get(driver_id=driver_id)
    driver.dr_status = 'Active'
    driver.save()
    return JsonResponse({'status': 'success'})

@transaction.atomic
def confirmed(request, user_id, distance, ride_type, driver_id, pickup, dropoff):
    user = Users.objects.get(user_id=user_id)
    driver = Driver.objects.get(driver_id=driver_id)
    paymentAmount = 0
    if ride_type == 'car':
        paymentAmount = 5 + (10 * distance) + 100
    elif ride_type == 'bike':
        paymentAmount = 5 + (10 * distance) + 40
    elif ride_type == 'auto':
        paymentAmount = 5 + (10 * distance) + 60
    context = {'user': user, 'distance': distance, 'ride_type': ride_type, 'driver': driver, 'paymentAmount': paymentAmount, 'pickup': pickup, 'dropoff': dropoff}
    return render(request, 'RideEase/confirmed.html', context)