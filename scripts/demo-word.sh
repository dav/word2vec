DATA_DIR=../data
BIN_DIR=../src

pushd ${BIN_DIR} && make; popd

if [ ! -e $DATA_DIR/text8 ]; then
  wget http://mattmahoney.net/dc/text8.zip -O $DATA_DIR/text8.gz
  gzip -d $DATA_DIR/text8.gz -f
fi

echo -----------------------------------------------------------------------------------------------------
echo -- Training...
time $BIN_DIR/word2vec -train $DATA_DIR/text8 -output $DATA_DIR/vectors.bin -cbow 0 -size 200 -window 5 -negative 0 -hs 1 -sample 1e-3 -threads 12 -binary 1

echo -----------------------------------------------------------------------------------------------------
echo -- Calculating distance...

$BIN_DIR/distance $DATA_DIR/vectors.bin
