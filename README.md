# webmapper

need to do sth about the output of gobuster when i cancel the script
maybe sth like call another script that waits for gobuster pid to finish
while kill -0 PIDOFGOBUSTER 2> /dev/null; do sleep 1; done;

u need "gobuster" and "dot" to run this

g.sh <-u URL> <-o file> [-t 40] [-w Wordlist] [-p 127.0.0.1:8080]

makeSVGgraph.sh<urlfile> <target> [-i == ignoreCase]

run them together like this
g.sh -u http://10.11.1.73:8080/php/skins -o urls.txt

makeSVGgraph.sh urls.txt mygraph -i

firefox mygraph.svg  
