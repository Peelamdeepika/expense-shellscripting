#!/bin/bash

USERID=(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"

FOLDERNAME="/var/log/backend-logs"
FILE=$(basename "$0")
TIMESTAMP=$(date +%y-%m-%d)
FILENAME="$FOLDERNAME_$FILE/$FILE-$TIMESTAMP.log"

CHECK_ROOT() {
    if [ $USERID -ne 0 ]; then
      echo "you need $R root access"
      exit 1
    fi  
}

VALIDATE() {
   if [ $1 -ne 0 ]; then
   echo -e "$2...$R failure"
   exit 1
else
   echo -e "$2...$G success"
fi 
}

CHECK_ROOT

mkdir /var/log/backend-logs

VALIDATE $? "created logs folder"

dnf module disable nodejs -y &>>$FILENAME

VALIDATE $? "diabling module nodejs"

dnf module enable nodejs:20 -y

VALIDATE $? "enabling module js"

dnf install nodejs -y

VALIDATE $? "installing node js'

useradd expense

VALIDATE $? "adding user"

mkdir /app

VALIDATE $? "app folder created"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip

VALIDATE $? "application download'

cd /app

VALIDATE $? "moved to app folder"

unzip /tmp/backend.zip

VALIDATE $? "unzipping application"

cd /app

VALIDATE $? "moved to app folder"

npm install

VALIDATE $? "installing npm"

cp /home/ec2-user/expense-shellscripting/backendservice /etc/systemd/system/

VALIDATE $? "Copied"

systemctl daemon-reload

VALIDATE $? "daemon reloaded"

systemctl start backend

VALIDATE &? "started backend"

systemctl enable backend

VALIDATE $? "backend enabled"

dnf install mysql -y

VALIDATE $? "mysql installed'

mysql -h <mysql.daws82deepika.online> -uroot -pExpenseApp@1 < /app/schema/backend.sql

systemctl restart backend

VALIDATE $? "backend restarted"
