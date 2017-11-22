#!/bin/bash
DIR=`S=\`readlink "$0"\`; [ -z "$S" ] && S=$0; dirname $S`
cd $DIR
lw_except(){
    /usr/bin/expect -c "
set timeout 10
spawn ssh $1
expect \"*password:\"
send \"$2\r\"
expect \"*#\"
interact
"
}

lw_add(){
echo $1
    echo $1>>../data/test.conf
    echo 'success'
}

lw_ssh(){
    conf=`grep "^\$1\b" ../data/test.conf`
    
    if test -n "$conf"
    then
    one=($conf)
    case $one[4] in
        key)
            echo 'no work';;
        password)
            lw_except ${one[2]}"@"${one[1]} ${one[3]};;
        *)
            lw_except ${one[2]}"@"${one[1]} ${one[3]};;
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

