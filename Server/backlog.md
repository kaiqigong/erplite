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