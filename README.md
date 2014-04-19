#Erplite
This is a ERP for small business.

Use AngularJS for frontend MVC.
Use Bootstrap for responsive design.

Use REST api for backend.

Run Client Demo with mock data:

cd erplite
node scripts/web-server.js

open localhost:8000/app/index.html

##Start django server<br>
create database in mysql <br>

change mysql configs in Server/Server/settings.py<br>
```
cd erplite
python Server/manage.py syncdb
python Server/manage.py runserver
```

##Start Client
###Install
We use bower to manage vendor libs
```
cd erplite
npm install
bower install
```
open localhost:8000/app/index.html
###Run test
###Build

##Contribute to Erplite
###Use CoffeeScript
install coffeescript
```bash
sudo npm install -g coffee-script
```
Add syntax and snippet to TextMate or Subline
[coffee-script-tmbundle](https://github.com/jashkenas/coffee-script-tmbundle)

build the coffees

###Editor Config
Please follow the indent in `.editorconfig`  
You may need this [plugin](https://github.com/sindresorhus/editorconfig-sublime) in Sublime.  
Others please refer to [EditorConfig](http://editorconfig.org/)
