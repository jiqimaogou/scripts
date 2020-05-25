sh review_site/bin/gerrit.sh stop

echo "nginx"
brew install nginx

wget -c https://gerrit-releases.storage.googleapis.com/gerrit-3.1.4.war

java -jar gerrit-3.1.4.war init --batch -d review_site

cd review_site/etc

perl -pi.bak -e 's/OPENID/HTTP/g' gerrit.config

touch passwd

htpasswd -b passwd admin admin

sh review_site/bin/gerrit.sh start

open http://localhost:8081
