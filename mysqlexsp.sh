#!/bin/bash

USERNAME=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"

USERID() {
    if [ $USERNAME -ne 0 ]; then
       echo -e "you need root access to  $Y continue"
       exit 1
    fi
}

FOLDERNAME="/var/log/expenseshell-logs"
TIMESTAMP=$(date +%y-%m-%d)
FILE=$(basename "$0")
FILENAME="$FOLDERNAME/$FILE-$TIMESTAMP.log"

VALIDATE() {
    if [ $1 -ne 0 ]; then
       echo -e "$2 $R Failure"
       exit 1
       else
       echo -e "$2 ... $G Successful" 
    fi
}

mkdir -p /var/log/expenseshell-logs

USERID

dnf install mysql-server -y &>>$FILENAME

VALIDATE $? "mysql server installation"

systemctl enable mysqld &>>$FILENAME

VALIDATE $? "mysql enabled"

systemctl start mysqld &>>$FILENAME

VALIDATE $? "mysql started"

mysql -h mysql.daws82deepika.online -u root -pExpenseApp@1 -e 'show databases;'

if [ $? -ne 0 ]; then
   echo " your root password might not set...setting root passwor"
   mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$FILENAME
   VALIDATE $? "your root password has set" 
   else
   echo "Your root password is already setup"
fi













