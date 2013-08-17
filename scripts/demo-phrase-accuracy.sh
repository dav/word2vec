make
if [ ! -e text8 ]; then
  wget http://mattmahoney.net/dc/text8.zip -O text8.gz
  gzip -d text8.gz -f
fi
echo ----------------------------------------------------------------------------------------------------------------
echo Note that the accuracy and coverage of the test set questions is going to be low with this small training corpus
echo To achieve better accuracy, larger training set is needed
echo ----------------------------------------------------------------------------------------------------------------
time ./word2phrase -train text8 -output text8-phrase -threshold 500 -debug 2 -min-count 3
time ./word2vec -train text8-phrase -output vectors-phrase.bin -cbow 0 -size 300 -window 10 -negative 0 -hs 1 -sample 1e-3 -threads 12 -binary 1 -min-count 3
./compute-accuracy vectors-phrase.bin <questions-phrases.txt
