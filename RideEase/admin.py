from django.contrib import admin
from .models import *
# Register your models here.

admin.site.register(Bookings)
admin.site.register(Driver)
admin.site.register(Vehicle)
admin.site.register(Ride)
admin.site.register(Users)
admin.site.register(Drivesfor)
admin.site.register(Payment)
admin.site.register(Discountoffers)

