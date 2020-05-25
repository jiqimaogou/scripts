echo "nginx"
brew install nginx

wget -c https://gerrit-releases.storage.googleapis.com/gerrit-3.1.4.war

java -jar gerrit.war init --batch -d review_site

sh review_site/bin/gerrit.sh start

open http://localhost:8081

cd review_site/etc

touch passwd

