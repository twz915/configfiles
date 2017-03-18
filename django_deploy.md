使用时需要把 `{project_name}` 替换成真实的项目名称。
# nginx 配置
添加到 `http` 中
```
    upstream {project_name}_server {
        server 127.0.0.1:7001;
        #server unix:///tmp2/{project_name}.sock;
    }

    server {
        listen       80;
        server_name  example.com;

        charset utf-8;

        access_log  /home/admin/{project_name}.access.log;

        location ^~ /static/ {
            root   /home/tu/{project_name};
        }

        location / {
            uwsgi_pass  {project_name}_server;
            include uwsgi_params;
        }
    }
```
## 测试 nginx 配置
$**sudo /usr/local/nginx/sbin/nginx -t**
nginx: the configuration file /usr/local/nginx/conf/nginx.conf syntax is ok
nginx: configuration file /usr/local/nginx/conf/nginx.conf test is successful

## 使更改生效
$**sudo /usr/local/nginx/sbin/nginx -s reload**


# supervisor 配置
```
[program:{project_name}]
command=/home/tu/.virtualenvs/{project_name}/bin/uwsgi --ini /home/tu/{project_name}/uwsgi.ini
directory=/home/tu/{project_name}
user=tu
stdout_logfile=/home/tu/{project_name}.log
stderr_logfile=/home/tu/{project_name}.log
```

# uwsgi 配置 
uwsgi.ini  (2.0.14版本）
```
[uwsgi]
# the base directory (full path) /path/to/your/project
chdir = /home/tu/{project_name}
# the virtualenv (full path)
home = /home/tu/.virtualenvs/{project_name}/

socket = :7001
;socket = /tmp2/{project_name}.sock
wsgi-file = {project_name}/wsgi.py

chmod-socket = 666
;chown-socket=nobody:nobody
;uid=nobody
;gid=nobody

process = 2
threads = 4
master = true
vacuum = true

buffer-size = 65535
stats = 0.0.0.0:5001
```
socket 文件最好不要放在 /tmp/ 中，有些系统的临时文件是 namespaced 的，进程只能看到自己的临时文件，导致 nginx 找不到 uwsgi 的 socket 文件，nginx显示502，日志中 unix: /tmp/xxx.sock failed (2: No such file or directory)，所以部署的时候建议用其它目录来放 socket 文件，比如放在运行nginx用户目录中，比如 /run/app.sock，详细参考 http://stackoverflow.com/questions/32974204/got-no-such-file-or-directory-error-while-configuring-nginx-and-uwsgi
也可以弄一个专访的目录来放 socket 文件，比如 /tmp2/
```
sudo mkdir -p /tmp2/ && sudo chmod 777 /tmp2/
```

# 自动拉取最新代码，并重启项目
请确保不要在服务器上更改代码，**使用这个脚本会使得更改的部分内容丢失！！！**
以下保存成 `update.sh`，当代码更改 Push 到 git 库后，在服务器上执行这个即可完成部署：
```
date +"Now: %F %T"

# uwsgi socket file path
sudo mkdir -p /tmp2/ && sudo chmod 777 /tmp2/

source /home/tu/.virtualenvs/{project_name}/bin/activate
pip install --upgrade pip

# 下面两行是可选内容，以下是为每个项目配置不同的 uwsgi 和 supervisor。当然你也可以使用一个总的 uwsgi 和 supervisor
pip install supervisor uwsgi
supervisord -c /home/tu/{project_name}/supervisord.conf

git stash
git pull

pip install -r requirements.txt

chmod +x manage.py

./manage.py compilemessages
./manage.py migrate
echo "collect static files ..."
./manage.py collectstatic -v 0 --noinput

chmod -R a+r static

# restart
supervisorctl update
supervisorctl restart {project_name}
#sudo chmod 666 /tmp/{project_name}.sock

git stash clear
```
