#!/bin/bash
if[ $# -ne 2 ];then
	echo "$0 <url> <out.txt>";
	exit -1;
fi
endpoints=`cat $1`;
out=$2
for endpoint in $endpoints;
do
	curl -k $endpoint  | sort | uniq | grep -oE '(href=".*"|src=".*")' | sed "s/href=\"//g" | sed "s/src=\"//g" | sed "s/\".*//g" | sort | uniq >> uris-scraped.txt
done


