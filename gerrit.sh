echo "停止服务："
nginx -s stop
sh review_site/bin/gerrit.sh stop

echo "安装服务："
echo "nginx"
brew install nginx

wget -c https://gerrit-releases.storage.googleapis.com/gerrit-3.1.4.war

echo "生成服务目录："
java -jar gerrit-3.1.4.war init --batch -d review_site

echo "修改服务登录配置："
cd review_site/etc

perl -pi.bak -e 's/OPENID/HTTP/g' gerrit.config
perl -pi.bak -e 's/http:\/\/localhost:8080//http:\/\/gerrit.bmsoft.com/g' gerrit.config

echo "生成用户名和密码："
touch passwd
htpasswd -b passwd admin admin

cd -

echo "修改nginx配置："
cp /usr/local/etc/nginx/nginx.conf review_site
cp /usr/local/etc/nginx/mime.types review_site

perl -pi.bak -e 's/listen       8080;/listen       80;/g' review_site/nginx.conf
sed -i '' '79i\
      location ^~ / {\
            auth_basic "Restricted";\
            auth_basic_user_file  /tmp/review_site/etc/passwd;\
        	proxy_pass        http://127.0.0.1:8099;\
        	proxy_set_header  X-Forwarded-For $remote_addr;\
        	proxy_set_header  Host $host;\
      }
' review_site/nginx.conf
sed -i '' '43,46d' review_site/nginx.conf

echo "启动nginx配置："
nginx -c `pwd`/review_site/nginx.conf

nginx -s reload

sh review_site/bin/gerrit.sh start

open http://localhost:8081
