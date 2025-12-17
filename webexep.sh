#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

FOLDERNAME="/var/log/webserver-logs"
TIMESTAMP=$(date +%y-%m-%d)
FILENAME=$(echo "$0")
FILE="$FOLDERNAME/$FILENAME-$TIMESTAMP.log"

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
      echo -e "you need  $R root access"
      exit 1
fi

VALIDATE() {
    if [ $? -ne 0 ]; then
        echo -e " $2 ...$R failure$N"
        exit 1
         else
        echo -e "$2 ..$G Success$N"
    fi
}

mkdir -p /var/log/webserver-logs

dnf install nginx -y &>>$FILE

VALIDATE $? "nginx installed"

systemctl enable nginx &>>$FILE

VALIDATE $? "nginx enabled"

systemctl start nginx &>>$FILE

VALIDATE $? "nginx started"

rm -rf /usr/share/nginx/html/* &>>$FILE

VALIDATE $? "removing old page"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$FILE

VALIDATE $? "downloading application zip file"

cd /usr/share/nginx/html &>>$FILE

VALIDATE $? "moving to html folder"

rm -rf /html* &>>$FILE

unzip /tmp/frontend.zip &>>$FILE

VALIDATE $? "unziping file"

cp /home/ec2-user/expense-shellscripting/expense.conf /etc/nginx/default.d/ &>>$FILE

VALIDATE $? "copied Proxy Configuration"

systemctl restart nginx &>>$FILE

VALIDATE $? "nginx started"





