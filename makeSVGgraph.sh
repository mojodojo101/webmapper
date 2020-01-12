#!/bin/sh
usage="$1 <urlfile> <target> [-i == ignoreCase]"
echo "$1 $2 $3"
if [ $# -lt 2 ];then
	echo $usage
	exit 2
fi
if [ -z $3 ];then
	urls=`cat $1 |sed "s/ (.*)//g" | sort | uniq`;
else
	urls=`cat $1 |sed "s/ (.*)//g" | tr '[:upper:]' '[:lower:]' | sort | uniq`;
fi
hostname=`echo $urls | head -1 |  cut -d'/' -f1-3`
nodes=""
header='graph Site {\ngraph [overlap=false\n rankdir ="LR"\noutputMode="edgesfirst"\n ranksep = "1.2 equally"\n];\n'
footer='
}
'
masternode='"'$hostname'"'' [URL="'$hostname'"];\n'
make_node()
{
nodeurl=$1
nodelabel=`echo $nodeurl | grep -o "/[^/]*$"`
parent=`echo $nodeurl | rev | cut -d '/' -f 2- | rev` 
nodes=$nodes'"'$nodeurl'" [label="'$nodelabel'"]'' [URL="'$nodeurl'"];\n"'$parent'" -- "'$nodeurl'";\n'
}

for url in $urls;
do
	make_node $url
done
gv=$2".gv"
svg=$2".svg"
echo "$header $masternode $nodes $footer" > $gv
dot -Tsvg $gv -o $svg
