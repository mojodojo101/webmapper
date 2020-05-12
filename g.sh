#!/bin/sh
usage()
{
echo "g.sh <-u URL> <-o file> [-t 40] [-w Wordlist] [-p 127.0.0.1:8080]" 
echo "$*" 
exit 2
}

while getopts "u:o:t:p:w:i:?h" opt; do
  case $opt in
    u) url="-u $OPTARG"   ;;
    w) wordlist="-w $OPTARG" ;;
    t) threads="-t $OPTARG" ;;
    o) out=$OPTARG   ;;
    p) proxy="-p $OPTARG"   ;; 
    i) ignore=" --wildcard -s $OPTARG"	;;
    h|?|*) usage ;;
  esac
done
missing=""
if [ -z "$url" ]; then
	missing=$missing" -u"	
fi

if [ -z "$out" ]; then
	missing=$missing" -o"	
fi
if [ -n "$missing" ]; then
	usage;
fi

if [ -z "$threads" ]; then
	threads="-t 40"
fi	

if [ -z "$wordlist" ];then
	wordlist="-w /usr/share/seclists/Discovery/Web-Content/raft-large-directories.txt"
fi
cat  gobusterGarbageFile.txt >> $out;
gobuster dir $url $wordlist -o gobusterGarbageFile.txt --timeout 60s $threads $proxy -e -k $ignore -a "Mozilla";
cat  gobusterGarbageFile.txt >> $out;
rm gobusterGarbageFile.txt;
