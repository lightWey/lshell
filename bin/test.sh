#!/bin/bash
/usr/bin/expect <(cat <<'EOF'
set timeout -1
spawn ssh root@106.15.207.214
expect "*password:"
send "lightway\r"
expect "*#"
send "ll\r"
expect "*#"
interact
expect eof
EOF
)
