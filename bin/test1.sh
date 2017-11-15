#!/usr/bin/expect
set timeout 10
spawn ssh root@106.15.207.214
expect "*password:"
send "lightway\r"
expect "*#"
#expect >> test.txt
interact
