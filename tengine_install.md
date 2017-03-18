# 安装 Tengine

官网 http://tengine.taobao.org

# 源码编译，安装 tengine
以下理论上适用 CentOS 5/6/7，但是目前只在 CentOS 7 和 alios 7 上测试过
操作帐户需要有 `sudo` 权限，把下面的内容保存成 `tengine_install.sh` 执行即可。
```
# 下载编译 tengine(nginx) 
echo "安装 tengine(nginx) 依赖"
sudo yum install pcre-devel openssl-devel -y

echo "创建 tengine-src 文件夹...";
mkdir tengine-src
cd tengine-src

echo "下载 tengine 源代码...";
wget http://tengine.taobao.org/download/tengine-2.2.0.tar.gz

echo "解压下载文件...";
tar -xvzf tengine-2.2.0.tar.gz

echo "编译tengine...";
cd tengine-2.2.0
./configure
make -j2

echo "tengine(nginx) 编译完成，安装";
sudo make install

echo "启动tengine(nginx)，配置文件在 /usr/local/nginx/conf 中";
# sudo /usr/local/nginx/sbin/nginx -s start
```

## 设置tengine开机自启
nginx官方教程：https://www.nginx.com/resources/wiki/start/topics/examples/initscripts/

以下适用于 CentOS 7 或 alios 7，对官方的 systemd conf进行了相应的路径更改，其它版本可参考上面的链接。
终端上执行下面的内容即可：
```
echo "添加tengine(nginx)自启动脚本 参考：https://www.nginx.com/resources/wiki/start/topics/examples/initscripts/"
echo '''[Unit]
Description=The NGINX HTTP and reverse proxy server
After=syslog.target network.target remote-fs.target nss-lookup.target
[Service]
Type=forking
PIDFile=/usr/local/nginx/logs/nginx.pid
ExecStartPre=/usr/local/nginx/sbin/nginx -t
ExecStart=/usr/local/nginx/sbin/nginx
ExecReload=/bin/kill -s HUP $MAINPID
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true
[Install]
WantedBy=multi-user.target
''' > ./nginx.service
sudo cp ./nginx.service /lib/systemd/system/nginx.service

sudo systemctl enable nginx
sudo systemctl start nginx
```

# 用 yum/apt-get 安装
适用于 CentOS 5/6/7
```
sudo yum install epel-release
sudo yum install nginx
```
适用于 Ubuntu
```
sudo apt-get install nginx
```
