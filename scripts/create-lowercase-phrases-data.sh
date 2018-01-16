#!/bin/bash

DATA_DIR=../data
BIN_DIR=../bin
SRC_DIR=../src

GZIPPED_DATA=$DATA_DIR/news.2012.en.shuffled.gz
TEXT_DATA=$DATA_DIR/news.2012.en.shuffled
NORM0=$DATA_DIR/news.2012.en.shuffled-norm0
PHRASE0=$DATA_DIR/news.2012.en.shuffled-norm0-phrase0
PHRASE1=$DATA_DIR/news.2012.en.shuffled-norm0-phrase1
LOWERCASE_PHRASES=$DATA_DIR/news.2012.en.shuffled-norm1-phrase1
LOWERCASE_PHRASES_VECTOR_DATA=$DATA_DIR/lowercase-vectors-phrase.bin

if [ ! -e $LOWERCASE_PHRASES_VECTOR_DATA ]; then
  if [ ! -e $LOWERCASE_PHRASES ]; then
	if [ ! -e $TEXT_DATA ]; then
	  if [ ! -e $GZIPPED__DATA ]; then
		wget http://www.statmt.org/wmt14/training-monolingual-news-crawl/news.2012.en.shuffled.gz -O $GZIPPED_DATA
	  fi
	  gzip -d $GZIPPED_DATA -f
    fi
	
	echo -----------------------------------------------------------------------------------------------------
	echo -- "Creating normalized version of word data (output: $NORM0)"

	sed -e "s/’/'/g" -e "s/′/'/g" -e "s/''/ /g" < $DATA_DIR/news.2012.en.shuffled | tr -c "A-Za-z'_ \n" " " > $NORM0

	echo -----------------------------------------------------------------------------------------------------
	echo "-- Creating lowercased phrases (output: $LOWERCASE_PHRASES)"

	time $BIN_DIR/word2phrase -train $NORM0 -output $PHRASE0 -threshold 200 -debug 2
	time $BIN_DIR/word2phrase -train $PHRASE0 -output $PHRASE1 -threshold 100 -debug 2
	tr A-Z a-z < $PHRASE1 > $LOWERCASE_PHRASES
  fi

  echo -----------------------------------------------------------------------------------------------------
  echo "-- Creating phrases (output: $LOWERCASE_PHRASES_VECTOR_DATA)..."
  time $BIN_DIR/word2vec -train $LOWERCASE_PHRASES -output $LOWERCASE_PHRASES_VECTOR_DATA -cbow 1 -size 200 -window 10 -negative 25 -hs 0 -sample 1e-5 -threads 20 -binary 1 -iter 15
fi
