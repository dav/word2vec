#!/bin/bash

DATA_DIR=../data
BIN_DIR=../bin
SRC_DIR=../src

pushd ${SRC_DIR} && make; popd
sh ./create-lowercase-phrases-data.sh

set -x
$BIN_DIR/distance $DATA_DIR/lowercase-vectors-phrase.bin
