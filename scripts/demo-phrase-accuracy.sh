#!/bin/bash

DATA_DIR=../data
BIN_DIR=../bin
SRC_DIR=../src

pushd ${SRC_DIR} && make; popd
sh $DATA_DIR/create-lowercase-phrases-data.sh

set -x
$BIN_DIR/compute-accuracy $DATA_DIR/lowercase-vectors-phrase.bin < $DATA_DIR/questions-phrases.txt
