CC = g++
PROJECT_DIR = .
SRC_DIR = $(PROJECT_DIR)/src
INC_DIR = $(PROJECT_DIR)/inc
OBJ_DIR = $(PROJECT_DIR)/obj
BIN_DIR = $(PROJECT_DIR)/bin
LIB_DIR = $(PROJECT_DIR)/lib

SAMPLE_DIR = $(PROJECT_DIR)/sample

SRC = dcc.cpp lexer.cpp AST.cpp parser.cpp codegen.cpp
OBJ = $(SRC:%.cpp=%.o)

TOOL = $(BIN_DIR)/dcc
CONFIG = llvm-config
LLVM_FLAGS = --cxxflags --ldflags --libs
INC_FLAGS = -I$(INC_DIR)

.PHONY: all
all: $(TOOL)

.PHONY: clean
clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR) $(LIB_DIR)/printnum.ll

.PHONY: run
run: all lib
	$(TOOL) -o $(SAMPLE_DIR)/test.ll -l $(LIB_DIR)/printnum.ll $(SAMPLE_DIR)/test.dc -jit

.PHONY: link
link: $(SAMPLE_DIR)/link_test.ll

.PHONY: lib
lib: $(LIB_DIR)/printnum.ll

.PHONY: do
do: link
	lli $(SAMPLE_DIR)/link_test.ll

$(TOOL): $(addprefix $(OBJ_DIR)/,$(OBJ))
	mkdir -p $(BIN_DIR)
	$(CC) -g $^ $(INC_FLAGS) `$(CONFIG) $(LLVM_FLAGS)` -ldl -o $(TOOL)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	mkdir -p $(OBJ_DIR)
	$(CC) -g $< $(INC_FLAGS) `$(CONFIG) $(LLVM_FLAGS)` -c -o $@ 

$(SAMPLE_DIR)/test.ll: $(SAMPLE_DIR)/test.dc $(TOOL)
	$(TOOL) -o $@ $<

$(LIB_DIR)/printnum.ll: $(LIB_DIR)/printnum.c
	clang -emit-llvm -S -O -o $@ $<

$(SAMPLE_DIR)/link_test.ll: $(SAMPLE_DIR)/test.ll $(LIB_DIR)/printnum.ll $(TOOL)
	llvm-link $(SAMPLE_DIR)/test.ll $(LIB_DIR)/printnum.ll -S -o  $@
