#!/bin/bash

endpoints=`cat $1`;

for endpoint in $endpoints;
do
	curl $endpoint  | sort | uniq | grep -oE '(href=".*"|src=".*")' | sed "s/href=\"//g" | sed "s/src=\"//g" | sed "s/\".*//g" | sort | uniq >> uris-scraped.txt
done


