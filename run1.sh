#!/bin/bash

mkdir $4
mkdir $5
cd $4 
touch train.csv
cd ..
cd $5
touch val.csv
cd ..


COUNT=$(wc -l < $1/dataset.csv)
COUNT=$(echo $COUNT)
nb_lines=${COUNT%% *}

TRAIN_RATIO=$(($COUNT * $3 / 100))
VAL_RATIO=$((TRAIN_RATIO + 1))

if [[ "$2" == 1 ]]; then
    cat $1/dataset.csv | gshuf > $1/new_dataset.csv
    cat $1/new_dataset.csv | sed -n "2,$TRAIN_RATIO p" >> $4/train.csv
    cat $1/new_dataset.csv | sed -n "$VAL_RATIO,$COUNT p" >> $5/val.csv
    rm $1/dataset.csv
else
    cat $1/dataset.csv | sed -n "2,$TRAIN_RATIO p" >> $4/train.csv
    cat $1/dataset.csv | sed -n "$VAL_RATIO,$COUNT p" >> $5/val.csv
fi
