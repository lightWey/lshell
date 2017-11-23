#!/bin/bash
DIR=`S=\`readlink "$0"\`; [ -z "$S" ] && S=$0; dirname $S`
cd $DIR
lw_expect_pwd(){
    /usr/bin/expect -c "
set timeout 10
spawn ssh $1
expect \"*password:\"
send \"$2\r\"
expect \"*#\"
interact
"
}

lw_expect_key(){
    /usr/bin/expect -c "
set timeout 10
spawn ssh $1
expect \"*passphrase*\"
send \"$2\r\"
expect \"*password:\"
send \"$2\r\"
expect \"*#\"
interact
"
}

lw_add(){
echo $1
    echo $1>>../data/data
    echo 'success'
}

lw_ssh(){
    conf=`grep "^\$1\b" ../data/data`
    
    if test -n "$conf"
    then
    one=($conf)
echo ${one[4]}
    case ${one[4]} in
        key)  
            lw_expect_key ${one[1]} ${one[3]};;
        pwd)
            lw_expect_pwd ${one[2]}"@"${one[1]} ${one[3]};;
    esac
    else
        echo 'no found option !'
    fi

}

case $1 in
    help)
        echo "help";;
    -help)
        echo "help";;
    -add)
        lw_add "$2";;
    [a-z]*)
        lw_ssh $1;;
        
esac

