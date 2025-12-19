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

FILES=$(find $SOURCE_DIR -name "*.log" -mmin +$DAYS)
ZIP_FILE="/$DEST_DIR/arch_log.zip"
if [ -n "$FILES" ]
  then
    echo " files are present"
    echo "$FILES"
    echo "$FILES" | zip -@ $ZIP_FILE
      if [ -f $ZIP_FILE ]
      then 
      echo "zip file is created"

      while read -r filepath
        do
           echo "deleting files in zip file"
            rm -rf $filepath
        done <<< $FILES

    esle "zip file is not created"
    exit 1
  fi
  
  else "files are not present"
  exit 1
fi


