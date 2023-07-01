from django.db import models
from django.db.models import Count
class Bookings(models.Model):
    booking_id = models.AutoField(db_column='Booking_ID', primary_key=True)  # Field name made lowercase.
    userid = models.ForeignKey('Users', models.DO_NOTHING, db_column='UserID', blank=True, null=True)  # Field name made lowercase.
    dri = models.ForeignKey('Driver', models.DO_NOTHING, db_column='Dri_ID', blank=True, null=True)  # Field name made lowercase.
    pickup = models.CharField(db_column='Pickup', max_length=50)  # Field name made lowercase.
    dropoff = models.CharField(db_column='Dropoff', max_length=50)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'bookings'
    
    def __str__(self):
        return self.pickup#self.userid


class Discountoffers(models.Model):
    discountid = models.AutoField(db_column='DiscountID', primary_key=True)  # Field name made lowercase.
    userlid = models.ForeignKey('Users', models.DO_NOTHING, db_column='userLID')  # Field name made lowercase.
    discount_detail = models.CharField(db_column='Discount_Detail', max_length=50, blank=True, null=True)  # Field name made lowercase.
    discount_percentage = models.IntegerField(db_column='Discount_Percentage')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'discountoffers'


class DjangoMigrations(models.Model):
    id = models.BigAutoField(primary_key=True)
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class Driver(models.Model):
    driver_id = models.AutoField(db_column='Driver_ID', primary_key=True)  # Field name made lowercase.
    fname = models.CharField(max_length=50)
    mname = models.CharField(max_length=50, blank=True, null=True)
    lname = models.CharField(max_length=50, blank=True, null=True)
    e_mail = models.CharField(db_column='E_mail', unique=True, max_length=100)  # Field name made lowercase.
    driverpassword = models.CharField(db_column='DriverPassword', max_length=50)  # Field name made lowercase.
    driver_rating = models.IntegerField(db_column='Driver_rating')  # Field name made lowercase.
    dr_status = models.CharField(db_column='Dr_Status', max_length=8)  # Field name made lowercase.
    dob = models.DateField(db_column='DOB')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'driver'

class Drivesfor(models.Model):
    drivid = models.OneToOneField(Driver, models.DO_NOTHING, db_column='DrivID', primary_key=True)  # Field name made lowercase.
    usrid = models.ForeignKey('Users', models.DO_NOTHING, db_column='UsrID')  # Field name made lowercase.
    tim = models.DateTimeField(db_column='Tim', unique=True, blank=True, null=True)  # Field name made lowercase.
    distance = models.FloatField(db_column='Distance')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'drivesfor'
        unique_together = (('drivid', 'usrid'),)


class Payment(models.Model):
    paymentid = models.AutoField(db_column='PaymentID', primary_key=True)  # Field name made lowercase.
    bookieid = models.ForeignKey(Bookings, models.DO_NOTHING, db_column='BookieID', blank=True, null=True)  # Field name made lowercase.
    payment_amount = models.IntegerField(db_column='Payment_Amount')  # Field name made lowercase.
    payment_method = models.CharField(db_column='Payment_Method', max_length=11)  # Field name made lowercase.
    payment_status = models.CharField(db_column='Payment_Status', max_length=7)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'payment'


class Ride(models.Model):
    vehiclesid = models.ForeignKey('Vehicle', models.DO_NOTHING, db_column='VehiclesID', blank=True, null=True)  # Field name made lowercase.
    rideid = models.AutoField(db_column='RideID', primary_key=True)  # Field name made lowercase.
    tracking = models.CharField(db_column='Tracking', max_length=50, blank=True, null=True)  # Field name made lowercase.
    r_type = models.CharField(db_column='R_Type', max_length=4)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'ride'


class RideeaseBooking(models.Model):
    booking_id = models.IntegerField(primary_key=True)
    pickup = models.CharField(max_length=100)
    driver_id = models.IntegerField(blank=True, null=True)
    dropoff = models.CharField(max_length=100)
    user_id = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'rideease_booking'


class RideeaseDriver(models.Model):
    driver_id = models.IntegerField(primary_key=True)

    class Meta:
        managed = False
        db_table = 'rideease_driver'


class Tracking(models.Model):
    tracking_id = models.AutoField(db_column='Tracking_ID', primary_key=True)  # Field name made lowercase.
    latitude = models.CharField(db_column='Latitude', max_length=50, blank=True, null=True)  # Field name made lowercase.
    longitude = models.CharField(db_column='Longitude', max_length=50, blank=True, null=True)  # Field name made lowercase.
    bookeid = models.ForeignKey(Bookings, models.DO_NOTHING, db_column='BookeID', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'tracking'


class UserPhone(models.Model):
    user = models.OneToOneField('Users', models.DO_NOTHING, db_column='User_ID', primary_key=True)  # Field name made lowercase.
    phone_number1 = models.CharField(db_column='Phone_number1', max_length=20)  # Field name made lowercase.
    phone_number2 = models.CharField(db_column='Phone_number2', max_length=20)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'user_phone'
        unique_together = (('user', 'phone_number1', 'phone_number2'),)


class Users(models.Model):
    user_id = models.AutoField(db_column='User_ID', primary_key=True)  # Field name made lowercase.
    fname = models.CharField(max_length=50)
    mname = models.CharField(max_length=50, blank=True, null=True)
    lname = models.CharField(max_length=50, blank=True, null=True)
    user_status = models.CharField(db_column='User_Status', max_length=6)  # Field name made lowercase.
    e_mail = models.CharField(db_column='E_mail', unique=True, max_length=100)  # Field name made lowercase.
    userpassword = models.CharField(db_column='UserPassword', max_length=50)  # Field name made lowercase.
    USERNAME_FIELD = 'fname'

    class Meta:
        managed = False
        db_table = 'users'


class Vehicle(models.Model):
    vehicle_id = models.AutoField(db_column='Vehicle_ID', primary_key=True)  # Field name made lowercase.
    driveeid = models.ForeignKey(Driver, models.DO_NOTHING, db_column='DriveeID', blank=True, null=True)  # Field name made lowercase.
    license_platenumber = models.CharField(db_column='License_Platenumber', unique=True, max_length=20)  # Field name made lowercase.
    model = models.CharField(db_column='Model', max_length=50)  # Field name made lowercase.
    make = models.CharField(db_column='Make', max_length=50)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'vehicle'

top_pickup_locations = Bookings.objects.values('pickup').annotate(count=Count('pickup')).order_by('-count')[:3]