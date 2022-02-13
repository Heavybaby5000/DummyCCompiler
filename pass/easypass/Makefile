CC = g++
PROJECT_DIR = .
SRC_DIR = $(PROJECT_DIR)/src
INC_DIR = $(PROJECT_DIR)/inc
OBJ_DIR = $(PROJECT_DIR)/obj
BIN_DIR = $(PROJECT_DIR)/bin

SAMPLE_DIR = $(PROJECT_DIR)/sample

PASS_SRC = easypass.cpp

PASS_SRC_PATH = $(SRC_DIR)/$(PASS_SRC)

PASS_OBJ = $(OBJ_DIR)/$(PASS_SRC:.cpp=.o)

LIB = $(BIN_DIR)/easypass.so
CONFIG = llvm-config
LLVM_FLAGS = --cxxflags
LLVM_FLAGS2 = --ldflags --libs
LLVM_FLAGS3 = --cxxflags --ldflags --libs
INC_FLAGS = -I$(INC_DIR)

.PHONY: all
all: $(LIB)

$(LIB): $(PASS_OBJ)
	mkdir -p $(BIN_DIR)
	$(CC) -g -shared -o $@ $<

$(PASS_OBJ):$(PASS_SRC_PATH)
	mkdir -p $(OBJ_DIR)
	$(CC) -g $< $(INC_FLAGS) `$(CONFIG) $(LLVM_FLAGS)` -c -o $@ -fPIC

.PHONY: clean
clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)

.PHONY: sample
sample: $(SAMPLE_DIR)/test.ll

$(SAMPLE_DIR)/test.ll: $(SAMPLE_DIR)/test.dc
	../../bin/dcc $< -o $@

.PHONY: run
run: $(SAMPLE_DIR)/test.ll $(LIB)
	opt -load $(LIB) -easypass -debug-pass=Structure $< -S > /dev/null
