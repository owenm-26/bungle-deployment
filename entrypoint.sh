#!/bin/bash

echo "Starting bungle"
echo "Starting mysql..."
service mysql start
while ! mysqladmin ping -h"127.0.0.1" --silent; do
    sleep 1
done
echo "mysql Started!"
echo "Initializing database..."
mysqladmin -u root password root
mysql -uroot -proot -e "create database project2;
                        create user 'project2'@'localhost' identified by 'a23e18e1ec8c0500c00fe45a4c37217e6a5cedd6008eb2b1';
                        create user 'project2-ro'@'localhost' identified by '1047283503fa3d4a618a3ed23f79c0a235b6695456871c5d';
                        grant insert,update,select on project2.* to 'project2'@'localhost';
                        grant select on project2.* to 'project2-ro'@'localhost';
                        use project2;
                        create table users (id int not null auto_increment, username varchar(32) not null, password varchar(32) not null, passwordhash blob(16), salt char(2) not null, primary key (id), unique index (username));
                        create table history (id int not null auto_increment, user_id int not null, query varchar(2048) not null, primary key (id), index (user_id));"

echo "Adding initial user..."
mysql -uroot -proot -e "USE project2;
INSERT INTO users (username, password, passwordhash, salt) VALUES ('victim', '719a67994e0d14244f00cb06a9f33371', MD5('a0719a67994e0d14244f00cb06a9f33371'), 'a0');"

echo "Starting Apache server"
rm /etc/apache2/apache2.conf
rm /etc/apache2/sites-available/000-default.conf
cp /bungle/bungle/apache_conf/apache2.conf /etc/apache2/
cp /bungle/bungle/apache_conf/000-default.conf /etc/apache2/sites-available/
/etc/init.d/apache2 start 

# Disable bash 
echo "exit" >> /root/.bashrc

# Sleep infinty
sleep infinity
