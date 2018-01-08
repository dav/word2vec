#!/bin/bash

DATA_DIR=../data
BIN_DIR=../bin
SRC_DIR=../src

VECTOR_DATA=$DATA_DIR/text8-vector.bin

pushd ${SRC_DIR} && make; popd
sh ./create-text8-vector-data.sh

set -x
$BIN_DIR/distance $VECTOR_DATA
