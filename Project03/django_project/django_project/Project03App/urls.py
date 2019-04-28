rom django.urls import path
from . import views

urlpatterns = [
    path('/login/', views.login , name='accounts-login_user_view'),
    , path('/createaccount/', views.create_account, name='accounts-createaccount')
    , path()

]
