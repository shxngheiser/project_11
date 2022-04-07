#!/bin/sh

sudo docker run -d -p 9889:80 -v /tmp/pr11/html:/var/www/html nginx

response=$(sudo curl --write-out "%{http_code}\n" --silent --output /dev/null localhost:9889)

if [ $response != 200 ] || [ $(sudo cat /tmp/pr11/html/index.html | md5sum | awk '{print $1}') != 1111 ]
then
  sudo sendmail artshanghai26@gmail.com < /tmp/pr11/email.txt
fi

sudo docker rm -f $(docker ps -a -q)

sudo docker rmi -f $(docker images -aq)