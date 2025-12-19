#!/bin/bash

SOURCE_DIR=$1
DESTI_DIR=$2
DAYS=${3:-0}



if [ $# -lt 2 ]
  then
  echo "source or destination dircetory is missing"
  exit 1
fi 

 if [ ! -d "$SOURCE_DIR" ] 
    then
     echo " not able to find $SOURCE_DIR"
     exit 1
fi

if [ ! -d "$DESTI_DIR" ]
  then 
     echo " not able to find $DESTI_DIR"
     exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mmin +$DAYS)

if [ -n "$FILES" ]
  then 
  echo " we are able to find files $FILES"
  ZIP_FILE="/home/ec2-user/arch_log/app_logs.zip"
  echo "$FILES" | zip -@ "$ZIP_FILE"
if [ -f $ZIP_FILE ]
 then
   echo " successfully created the $ZIP_FILE file"
  while read -r filepath
  do 
      echo "Deleting the $filepath"
      rm -rf "$filepath"
      echo "Deleted the $filepath"
  done <<< $FILES

 else
 echo "failed to create zipfile"
 exit 1
fi
else
echo "we are not able to find files"
fi