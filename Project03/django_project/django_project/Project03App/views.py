from django.shortcuts import render
from django.contrib.auth import authenticate, login
import matplotlib.pyplot as plt

def createaccount(request):
    user = User.objects.create_user(username='SomeUser',
                                password='SomePassword')
    return user

user = authenticate(request,username='SomeUser',password='SomePassword')
if user is not None:
   print("User is authenticated")
else:
   print("Invalid username or password")

def login_user_view(request):
    user = authenticate(request,username=request['username'],
                                password=request['password'])
    if user is not None:
        login(request,user)
        return HttpResponse("LoggedIn")
    else:
        return HttpResponse('LoginFailed')

def auth_only_view(request):
   user = request.user
      # currently logged in user
   if user.is_authenticated:
       HttpResponse("Authenticated User Stuff")

class UserInfoManager(models.Manager):
    def create_user_info(self, username, password, info):
        user = User.objects.create_user(username=username,
                                      password=password)
        userinfo = self.create(user=user,info=info)
        return userinfo

 class UserInfo(models.Model):
     user = models.OneToOneField(User,
                                 on_delete=models.CASCADE,
                                 primary_key=True)

     info = models.CharField(max_length=30)

     objects = UserInfoManager()


def age_graph(request):
    pass

def year_graph(request):
    pass

def school_graph(request):
    pass

def gpa_graph(request):
    pass

def program_graph(request):
    pass

def create_user(request):
