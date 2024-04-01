#!/bin/bash
echo -e "Please provide C filename you want to create : \c"
read -r file
touch $file.c
echo '#purpose : ' >>$file.c
echo '#created Date : ' $(date '+%d-%m-%Y') >>$file.c
echo '#Coder : SIBHU' >>$file.c
echo '#######--------START------######### # ' >>$file.c
echo '' >>$file.c
echo '' >>$file.c
echo '#include<stdio.h>' >>$file.c
echo '' >>$file.c
echo 'int main()' >>$file.c
echo '{' >>$file.c
echo '' >>$file.c
echo '' >>$file.c
echo '}' >>$file.c
echo '' >>$file.c
echo '' >>$file.c
echo '#####---------END-------######### ' >>$file.c

#chmod 777 template
#sudo mv template /bin/
