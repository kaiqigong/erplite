<h3>update 2014/03/27</h3>
<b>URL List:</b>
"contact": "http://localhost:8000/contacts/", <br>
"contactlink": "http://localhost:8000/contactlink/",<br> 
"contacttag": "http://localhost:8000/contacttag/", <br>
"contactdata": "http://localhost:8000/contactdata/"<br>
<b>Add South:</b>
first add south:<br>
./manage.py syncdb<br>
./manage.py schemamigration your_app --initial<br>
./manage.py migrate your_app --fake<br>
./manage.py migrate your_app<br>

<h3>update 2014/03/30</h3>
<b>Add query</b>
pip install django-filter<br>

"contact": "http://localhost:8000/contacts?name=&&description"<br>
"contactlink": "http://localhost:8000/contactlink?contact=&&tag="<br> 
"contacttag": "http://localhost:8000/contacttag?contact=&&keyPair=&&keyValue=" <br>
"contactdata": "http://localhost:8000/contactdata?contact=&&entityType&&entity"<br>

<h3>update 2014/04/01</h3>
<b>migration</b>
./manage.py schemamigration Contacts --auto #检测对models的更改<br>
./manage.py migrate Contacts #将更改反应到数据库（如果出现表已存在的错误，后面加 --fake）<br>

<h3>update 2014/04/09</h3>
<b>TokenAuthentication</b>
migrate db<br>
register user in page /account and get Authentication Token.<br>
For clients to authenticate, the token key should be included in the Authorization HTTP header. The key should be prefixed by the string literal "Token", with whitespace separating the two strings. For example:<br>
Authorization: Token 9944b09199c62bcf9418ad846dd0e4bbdfc6ee4b

###update 2014/04/15
**FileUpload**
Added FileUpload module.  
Added url to the media folder in root path. The folder is igonred in github.  
```post "files/upload" file:yourfile```  
File will be saved to media/files/ramdonpath/filename 

 ###update 2014/05/11
 add django-oauth2-provider to project
