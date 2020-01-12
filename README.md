# webmapper

need to do sth about the output of gobuster when i cancel the script
maybe sth like call another script that waits for gobuster pid to finish
while kill -0 PIDOFGOBUSTER 2> /dev/null; do sleep 1; done;
