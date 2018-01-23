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
expect {
\"*passphrase*\" {send \"$2\r\"}
\"*password:\" {send \"$2\r\"}
}
expect \"*#\"
interact
"
}

lw_add(){
echo $1
    echo $1>>../data/data
    echo 'success'
}

o_ssh(){
echo 'this is original ssh login ...'
    conf=`grep "^\$1\b" ../data/data`
    
    if test -n "$conf"
    then
    one=($conf)
echo 'please press command + v to login'
#copy password
echo ${one[3]} | pbcopy
    case ${one[4]} in
        key)
            ssh ${one[1]};;
        pwd)
            ssh ${one[2]}"@"${one[1]};;
    esac
    else
        echo 'no found option !'
    fi
}

lw_ssh(){
echo 'this is expect auto login ...'
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
	if [ $2 ];
	then
	echo $2
	else
	echo "help"
	fi;;
    -help)
        echo "help";;
    -add)
        lw_add "$2";;
    [a-z]*)
	if [ $2 ];
	then
	  case $2 in
	    -o)
	      o_ssh $1;;
	    -d)
	      lw_ssh $1;;
	  esac
	else
	lw_ssh $1
	fi;;
esac

