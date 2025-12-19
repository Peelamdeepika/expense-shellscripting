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

FIND=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)

if [ -n "$FIND" ]
  then 
  echo " we are able to find files $FIND"
  exit 1
fi





     

