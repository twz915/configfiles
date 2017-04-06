wsgi_websocket.py
```
import os
import gevent.socket
import redis.connection
import gevent.monkey
gevent.monkey.patch_thread()
redis.connection.socket = gevent.socket
os.environ["DJANGO_SETTINGS_MODULE"] = "mysite.settings"

from ws4redis.uwsgi_runserver import uWSGIWebsocketServer
application = uWSGIWebsocketServer()
```


uwsgi.ini
```
[uwsgi]
# the base directory (full path) /path/to/your/project
chdir = /home/tu/mysite
# the virtualenv (full path)
home = /home/tu/.virtualenvs/mysite/

http-socket = /tmp2/mysite_websocket.sock
wsgi-file = mysite/wsgi_websocket.py

chmod-socket = 666

gevent = 1000
http-websockets = true

process = 1
buffer-size = 65535

master = true
vacuum = true
```
