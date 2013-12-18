#!/bin/bash
echo "setup EC2 instance..."

sudo apt-get -y update
sudo apt-get -y upgrade

sudo apt-get -y install apache2 libapache2-mod-wsgi
sudo apt-get -y install python-pip
sudo pip install django
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password mysql'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password mysql'
sudo apt-get -y install mysql-server python-mysqldb
sudo apt-get -y install git-core
git clone https://github.com/ugik/Reviews.git

sudo rm /etc/apache2/httpd.conf
sudo touch /etc/apache2/httpd.conf
sudo chmod 777 /etc/apache2/*.conf
sudo echo "WSGIScriptAlias / /home/ubuntu/Reviews/WebApp/WebApp/wsgi.py" >> /etc/apache2/httpd.conf
sudo echo "WSGIPythonPath /home/ubuntu/Reviews/WebApp" >> /etc/apache2/httpd.conf
sudo echo "<Directory /home/ubuntu/Reviews/WebApp/WebApp>" >> /etc/apache2/httpd.conf
sudo echo "<Files wsgi.py>" >> /etc/apache2/httpd.conf
sudo echo "Order deny,allow" >> /etc/apache2/httpd.conf
sudo echo "Allow from all" >> /etc/apache2/httpd.conf
sudo echo "</Files>" >> /etc/apache2/httpd.conf
sudo echo "</Directory>" >> /etc/apache2/httpd.conf

sudo echo "Include httpd.conf" >> /etc/apache2/apache2.conf

cd /var/www
sudo mkdir static
sudo mkdir media
sudo chown www-data static/
sudo chown www-data media/

# assumes data.sql for data upload

cd ~
mysql -u root -pmysql -e "create database data; GRANT ALL PRIVILEGES ON data.* TO django@localhost IDENTIFIED BY 'django'"
mysql -u root -pmysql data < data.sql

sudo service apache2 restart

#http://nickpolet.com/blog/1/


