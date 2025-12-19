#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}


if [ $# -lt 2 ]
  then 
  echo " you should give <SOURCE_DIR> <DEST_DIR> <DAYS>"
  exit 1
fi

if [ ! -d $SOURCE_DIR ]
   then 
   echo "source dir is not available"
   exit 1
fi

if [ ! -d $DEST_DIR ]
   then 
   echo "destination dir is not available"
   exit 1
fi




