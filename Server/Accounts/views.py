#coding=utf-8
from django.core.urlresolvers import reverse
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render_to_response
from django.template import RequestContext
from django.contrib import messages
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login as auth_login ,logout as auth_logout
from django.utils.translation import ugettext_lazy as _
from forms import RegisterForm,LoginForm
from rest_framework.authtoken.models import Token

def index(request):
    '''首页视图'''
    template_var={"w":_(u"欢迎您 游客!"),"request":request,"name":request.user.username,"token":''}
    if request.user.is_authenticated():
        template_var["w"]=_(u"欢迎您 %s!")%request.user.username
        token = Token.objects.filter(user_id__exact=User.objects.get(username__icontains=request.user.username))
        if token:
            template_var["token"] = token[0]
    return render_to_response("accounts/welcome.html",template_var,context_instance=RequestContext(request))

def register(request):
    '''注册视图'''
    template_var={}
    form = RegisterForm()    
    if request.method=="POST":
        form=RegisterForm(request.POST.copy())
        if form.is_valid():
            username=form.cleaned_data["username"]
            email=form.cleaned_data["email"]
            password=form.cleaned_data["password"]
            user=User.objects.create_user(username,email,password)
            user.save()
            _login(request,username,password)#注册完毕 直接登陆
            return HttpResponseRedirect(reverse("index"))    
    template_var["form"]=form        
    return render_to_response("accounts/register.html",template_var,context_instance=RequestContext(request))
    
def login(request):
    '''登陆视图'''
    template_var={}
    form = LoginForm()    
    if request.method == 'POST':
        form=LoginForm(request.POST.copy())
        if form.is_valid():
            _login(request,form.cleaned_data["username"],form.cleaned_data["password"])
            return HttpResponseRedirect(reverse("index"))
    template_var["form"]=form        
    return render_to_response("accounts/login.html",template_var,context_instance=RequestContext(request))
    
def _login(request,username,password):
    '''登陆核心方法'''
    ret=False
    user=authenticate(username=username,password=password)
    if user:
        if user.is_active:
            auth_login(request,user)
            ret=True
        else:
            messages.add_message(request, messages.INFO, _(u'用户没有激活'))
    else:
        messages.add_message(request, messages.INFO, _(u'用户不存在'))
    return ret
    
def logout(request):
    '''注销视图'''
    auth_logout(request)
    return HttpResponseRedirect(reverse('index'))

def generate(request):
    if 'name' in request.GET:
        name = request.GET['name']
        user = User.objects.get(username__icontains=name)
        token = Token.objects.create(user=user)
        print token
        return HttpResponse(token)

