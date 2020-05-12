# webmapper


g.sh is just a wrapper around gobuster.


g.sh <-u URL> <-o file> [-t 40] [-w Wordlist] [-p 127.0.0.1:8080]

```sh
	g.sh -u http://10.11.1.73:8080/php/skins -o urls.txt

```


u need "dot" to run this

to get a nice little svg file with the url paths connected check out the example below:

makeSVGgraph.sh<urlfile> <target> [-i == ignoreCase]

run them together like this

g.sh -u http://10.11.1.73:8080/php/skins -o urls.txt

makeSVGgraph.sh urls.txt mygraph -i

firefox mygraph.svg  


this will merge the last run of g.sh with ur url file if u canceled the script (will add signal handler later):
cat gobusterGarbageFile.txt >> <g.sh out file>


