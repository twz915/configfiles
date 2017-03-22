以下适用于 CentOS 7，如果是 CentOS5/6，修改一下 `baseurl`后面的 el/7 把 7 改成对应的 5 或 6 即可。
操作帐户需要有 `sudo` 权限，把下面的内容保存成 `mysql_install.sh` 执行即可。
```
echo "安装MySQL相关"
echo '''# Enable to use MySQL 5.6
# /etc/yum.repos.d/
[mysql56-community]
name=MySQL 5.6 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.6-community/el/7/$basearch/
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql
''' > ./mysql56.repo

sudo cp ./mysql56.repo /etc/yum.repos.d/

sudo yum makecache
sudo yum install mysql-community-devel -y

echo "安装 MySQL-server"
sudo yum install mysql-community-server -y

echo "启动 MySQL-server"
sudo systemctl start mysqld

echo "开机自启 MySQL"
sudo systemctl enable mysqld


echo '''
====  MySQL使用指南  ====
-----------------------------------------------
MySQL 5.6 默认密码为空，mysql -uroot 直接可以进入
导入数据shell命令： cat bk.sql | mysql -uroot db
-- 创建数据库
CREATE DATABASE `dbname` DEFAULT CHARSET 'utf8';
ALTER DATABASE `dbname` CHARACTER SET 'utf8';

GRANT ALL ON dbname.* TO username@'%' IDENTIFIED BY 'password';

-- 创建只读帐户
REVOKE ALL ON dbname.* FROM 'readonly'@'localhost';
GRANT SELECT ON dbname.* TO 'readonly'@'localhost' IDENTIFIED BY 'password';
-- REVOKE ALL ON dbname.* FROM 'readonly'@'%';
-- GRANT SELECT ON dbname.* TO 'readonly'@'%' IDENTIFIED BY 'password';

-- 刷新权限，立即生效
FLUSH PRIVILEGES;
EXIT;
'''
```
更多可以参考MySQL官方教程：
https://dev.mysql.com/doc/mysql-yum-repo-quick-guide/en/
