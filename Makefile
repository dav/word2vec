DATA_DIR=./data
BIN_DIR=./bin
SRC_DIR=./src

clean:
	rm -f $(DATA_DIR)/vectors-phrase
	rm -f $(DATA_DIR)/vectors-phrase.bin
	rm -f $(DATA_DIR)/news.2012.en.shuffled-norm0
	rm -f $(DATA_DIR)/news.2012.en.shuffled-norm0-phrase1
	rm -f $(DATA_DIR)/news.2012.en.shuffled-norm1-phrase1

veryclean: clean
	rm -f $(DATA_DIR)/news.2012.en.shuffled
	rm -f $(DATA_DIR)/news.2012.en.shuffled.gz

build:
	pushd ${SRC_DIR} && make; popd
