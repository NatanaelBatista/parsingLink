
#!/bin/bash

package=$( dpkg -l | grep dnsutils )
if [ "$package" == "" ]
then
apt-get install dnsutils -y
fi

figlet=$( dpkg -l | grep figlet )
if [ "$figlet"  == ""]
then
apt-get install figlet -y
fi

figlet "ParsingLink"

if [ "$1" == "" ]
then
echo "Uso: $0 www.site.com"
else
if [ -e index.html ]
then
rm index.html
fi
wget "$1"
echo "Links encontrados:"
grep href index.html | cut -d ":" -f2 | cut -d "/" -f3 | grep "\." | grep -v "(" | grep -v "href" | grep -v "," | cut -d " " -f1 | cut -d "?" -f1 | sed 's/"//' | sed 's/>//' | sort -u > list

for url in $(cat list)
do
host $url | grep "has address"
done
fi
