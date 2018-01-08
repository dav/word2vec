#!/bin/bash

DATA_DIR=../data
BIN_DIR=../bin
SRC_DIR=../src

pushd ${SRC_DIR} && make; popd
sh $DATA_DIR/create-text8-data.sh

TEXT_DATA=$DATA_DIR/text8
CLASSES_DATA=$DATA_DIR/classes.txt

pushd ${SRC_DIR} && make; popd
  
if [ ! -e $CLASSES_DATA ]; then
  if [ ! -e $TEXT_DATA ]; then
		sh $DATA_DIR/create-text8-data.sh
	fi
  echo -----------------------------------------------------------------------------------------------------
  echo -- Training vectors...
  time $BIN_DIR/word2vec -train $TEXT_DATA -output $CLASSES_DATA -cbow 1 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -iter 15 -classes 500
fi

sort $CLASSES_DATA -k 2 -n > $DATA_DIR/classes.sorted.txt

echo The word classes were saved to file $DATA_DIR/classes.sorted.txt
