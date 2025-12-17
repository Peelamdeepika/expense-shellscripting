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

USERID








