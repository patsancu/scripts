#!/bin/bash

BEGIN_DATE=$1
NUMBER_OF_DAYS=$2
if [ $# -ne 2 ]; then
    echo "Usage: $0 begin_date number_of_days"
    exit 0;
fi

for i in `seq 0 $NUMBER_OF_DAYS`; do
    echo -n "Getting data for: " ;
    fecha=`date -d "$BEGIN_DATE $i days" +"%Y-%m-%d"`;
    echo $fecha;
    mkdir -p $fecha; cd $fecha;
    aws s3 cp --recursive s3://bucket-name/path/to/folders/$fecha/ .;
    cd ..;
done
