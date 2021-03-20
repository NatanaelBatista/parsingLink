#!/bin/bash

figlet "ParsingLink"

if [ "$1" == "" ]
then
echo "Use: $0 www.example.com"
else
if [ -e index.html ]
then
rm index.html
fi
wget "$1"
echo "Links found:"
grep href index.html | cut -d ":" -f2 | cut -d "/" -f3 | grep "\." | grep -v "(" | grep -v "href" | grep -v "," | cut -d " " -f1 | cut -d "?" -f1 | sed 's/"//' | sed 's/>//' | sort -u > list

for url in $(cat list)
do
host $url | grep "has address"
done
fi
