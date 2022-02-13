CC = g++
PROJECT_DIR = .
SRC_DIR = $(PROJECT_DIR)/src
INC_DIR = $(PROJECT_DIR)/inc
OBJ_DIR = $(PROJECT_DIR)/obj
BIN_DIR = $(PROJECT_DIR)/bin

SAMPLE_DIR = $(PROJECT_DIR)/sample

PASS_SRC = scevsample.cpp

PASS_SRC_PATH = $(SRC_DIR)/$(PASS_SRC)

PASS_OBJ = $(OBJ_DIR)/$(PASS_SRC:.cpp=.o)

LIB = $(BIN_DIR)/scevsample.so
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
sample: $(SAMPLE_DIR)/loop_m2r.ll

$(SAMPLE_DIR)/loop_m2r.ll: $(SAMPLE_DIR)/loop.c
	clang -emit-llvm -S -Xclang -disable-O0-optnone $< -o $(SAMPLE_DIR)/loop.ll
	opt -mem2reg -S $(SAMPLE_DIR)/loop.ll -o $@

.PHONY: run
run: sample all
	opt -load $(LIB) -scevsample -debug-pass=Structure  $(SAMPLE_DIR)/loop_m2r.ll -S > /dev/null
