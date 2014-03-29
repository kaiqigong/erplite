<h1>update 2014/03/27</h1>

<h2>URL List:</h2>
"contact": "http://localhost:8000/contacts/", <br>
"contactlink": "http://localhost:8000/contactlink/",<br> 
"contacttag": "http://localhost:8000/contacttag/", <br>
"contactdata": "http://localhost:8000/contactdata/"<br>

<h2>Add South:</h2>
first add south:<br>
./manage.py syncdb<br>

./manage.py schemamigration your_app --initial<br>

./manage.py migrate your_app --fake<br>

./manage.py migrate your_app<br>

-----------------------------------------------------------------------------------------<br>