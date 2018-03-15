#lshell
##Introduction
This is a shell tool.It can help us manage server records whether you use KEY or password to log in to the server
##origin
Whenever I try to connect many servers, I have to use Notepad to record all the connection information, because I use the MAC instead of Windows computer, so I wrote a simple app to help me manage server information , So I do not have to endure the OS X does not have enough shell tools to bring trouble
##Use
You just need to follow the `../data/example.data` file inside the specification to `../data/data`, fill in the information, you can use it.
###`example.data` information
```text
#This file is for storing basic service data
#
#Alias Host Username Password Type
#
#Alias : just a easy to remember name or service alias name
#Host : service host
#Username : your username
#Password : your password
#Type : login server type. You can write ‘pwd’ or 'key'. 'pwd' means login to the server by password and 'key' meads login by Public key

location1 127.0.0.1 root apple123 pwd
location2 myname - 123456 key
```
you can use `lshell location1`.If you want use `lrzsz` you should be use `lshell location1 -o` and we can show you something about password and you just press `command+v`.
##End
That's all
