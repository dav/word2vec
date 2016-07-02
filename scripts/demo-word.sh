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
  time $BIN_DIR/word2vec -train $TEXT_DATA -output $VECTOR_DATA -cbow 0 -size 200 -window 5 -negative 0 -hs 1 -sample 1e-3 -threads 12 -binary 1
  
fi

echo -----------------------------------------------------------------------------------------------------
echo -- distance...

$BIN_DIR/distance $DATA_DIR/$VECTOR_DATA
