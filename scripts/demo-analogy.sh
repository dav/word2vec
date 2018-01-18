#!/bin/bash

DATA_DIR=../data
BIN_DIR=../bin
SRC_DIR=../src

VECTOR_DATA=$DATA_DIR/text8-vector.bin

pushd ${SRC_DIR} && make; popd

echo -----------------------------------------------------------------------------------------------------
echo Note that for the word analogy to perform well, the models should be trained on much larger data sets
echo Example input: paris france berlin
echo -----------------------------------------------------------------------------------------------------

if [ ! -e $VECTOR_DATA ]; then
	sh ./create-text8-vector-data.sh
fi

set -x
$BIN_DIR/word-analogy $VECTOR_DATA
