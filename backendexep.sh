#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"

FOLDERNAME="/var/log/expenseshell-logs"
TIMESTAMP=$(date +%y-%m-%d)
FILE=$(echo "$0")
FILENAME="$FOLDERNAME/$FILE-$TIMESTAMP.log"

CHECK_ROOT() {
    if [ $USERID -ne 0 ]; then
      echo -e "you need $R root access"
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

dnf module enable nodejs:20 -y &>>$FILENAME

VALIDATE $? "enabling module js"

dnf install nodejs -y &>>$FILENAME

VALIDATE $? "installing node js"

useradd expense &>>$FILENAME

VALIDATE $? "adding user"

mkdir /app &>>$FILENAME

VALIDATE $? "app folder created"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$FILENAME

VALIDATE $? "application download"

cd /app &>>$FILENAME

VALIDATE $? "moved to app folder"

unzip /tmp/backend.zip &>>$FILENAME

VALIDATE $? "unzipping application"

cd /app &>>$FILENAME

VALIDATE $? "moved to app folder"

npm install &>>$FILENAME

VALIDATE $? "installing npm"

cp /home/ec2-user/expense-shellscripting/backend.service /etc/systemd/system/ &>>$FILENAME

VALIDATE $? "Copied"

systemctl daemon-reload &>>$FILENAME

VALIDATE $? "daemon reloaded"

systemctl start backend &>>$FILENAME

VALIDATE &? "started backend"

systemctl enable backend &>>$FILENAME

VALIDATE $? "backend enabled"

dnf install mysql -y &>>$FILENAME

VALIDATE $? "mysql installed"

mysql -h mysql.daws82deepika.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$FILENAME

VALIDATE $? "setting up the schema"

systemctl restart backend &>>$FILENAME

VALIDATE $? "backend restarted"
