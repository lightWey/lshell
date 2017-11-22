#!/bin/bash
DIR=`S=\`readlink "$0"\`; [ -z "$S" ] && S=$0; dirname $S`
echo '$0 = '${0}
echo 'readlink $0 ='`readlink $0`
E='null';
test -z `readlink $0` && E='not null'
echo $E
