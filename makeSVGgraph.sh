#!/bin/sh
# https://www.graphviz.org/doc/info/attrs.html check this out if you want to change attributes
#might want to change the way the args are parsed this is dones pretty lazy here or just give this entire thing an overhaul^^
usage="$1 <urlfile> <target> [-i == ignoreCase] [importantURIsFile]"
nodes=""
header='graph Site {\ngraph [overlap=false\n rankdir ="LR"\noutputMode="edgesfirst"\n ranksep = "1.2 equally"\nbgcolor="darkseagreen"\n];\n'
footer='}'
nodestyle=' [style=filled] [fillcolor="deepskyblue3"]'
importantNodestyle=' [style=filled] [fillcolor="red"]'
masterNodestyle=' [style=filled] [fillcolor="coral3"]'

if [ $# -eq 4 ];then
	important=`cat $4`
else
	important=""
fi
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

masternode='"'$hostname'"'' [URL="'$hostname'"]'$masterNodestyle';\n'
make_node()
{
nodeurl=$1
nodelabel=`echo $nodeurl | grep -o "/[^/]*$"`
parent=`echo $nodeurl | rev | cut -d '/' -f 2- | rev` 
nodetext='"'$nodeurl'" [label="'$nodelabel'"]'' [URL="'$nodeurl'"]'$nodestyle';\n"'$parent'" -- "'$nodeurl'";\n'
for imp in $important;
do
	if [ "$imp" = "$nodeurl" ];then
		nodetext='"'$nodeurl'" [label="'$nodelabel'"]'' [URL="'$nodeurl'"]'$importantNodestyle';\n"'$parent'" -- "'$nodeurl'";\n'
	fi;
done
nodes=$nodes$nodetext
}

for url in $urls;
do
	make_node $url
done
gv=$2".gv"
svg=$2".svg"
echo "$header $masternode $nodes $footer" > $gv
dot -Tsvg $gv -o $svg
