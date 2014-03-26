erplite
=======
This is a ERP for small business.

Use AngularJS for frontend MVC.
Use Bootstrap for responsive design.

Use REST api for backend.

Run Client Demo with mock data:

cd erplite
node scripts/web-server.js

open localhost:8000/app/index.html

Start django server<br>
=======
create database in mysql <br>

change mysql configs in Server/Server/settings.py<br>
```
cd erplite
python Server/manage.py syncdb
python Server/manage.py runserver
```

open localhost:8000<br>
open localhost:8000/app/index.html
