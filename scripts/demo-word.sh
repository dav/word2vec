#!/bin/bash

DATA_DIR=../data
BIN_DIR=../bin
SRC_DIR=../src

TEXT_DATA=$DATA_DIR/text8
ZIPPED_TEXT_DATA="${TEXT_DATA}.zip"
VECTOR_DATA=$DATA_DIR/text8-vector.bin

pushd ${SRC_DIR} && make; popd

if [ ! -e $VECTOR_DATA ]; then
  
  if [ ! -e $TEXT_DATA ]; then
    if [ ! -e $ZIPPED_TEXT_DATA ]; then
	    wget http://mattmahoney.net/dc/text8.zip -O $ZIPPED_TEXT_DATA
	fi
    unzip $ZIPPED_TEXT_DATA
	mv text8 $TEXT_DATA
  fi
  echo -----------------------------------------------------------------------------------------------------
  echo -- Training vectors...
  time $BIN_DIR/word2vec -train $TEXT_DATA -output $VECTOR_DATA -cbow 1 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

echo -----------------------------------------------------------------------------------------------------
echo -- distance...

$BIN_DIR/distance $DATA_DIR/$VECTOR_DATA
