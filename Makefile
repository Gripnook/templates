# Makefile template for compiling C++ projects.
# Author: Andrei Purcarus

CXX := clang++
CXXFLAGS := -std=c++14 -stdlib=libc++ -Wall -Wextra -pedantic -g

EXECUTABLE := app
BUILD_DIR := ./build
SRC := $(wildcard *.cpp)
OBJ := $(SRC:%.cpp=$(BUILD_DIR)/%.o)
DEP := $(OBJ:.o=.d)

all: $(EXECUTABLE)

$(EXECUTABLE): $(BUILD_DIR) $(BUILD_DIR)/$(EXECUTABLE)

$(BUILD_DIR):
	mkdir -p $@

$(BUILD_DIR)/$(EXECUTABLE): $(OBJ)
	$(CXX) $(CXXFLAGS) $^ -o $@

-include $(DEP)

$(BUILD_DIR)/%.o: %.cpp
	$(CXX) $(CXXFLAGS) -MMD -c $< -o $@

.PHONY: clean
clean:
	rm -f $(BUILD_DIR)/$(EXECUTABLE) $(OBJ) $(DEP)
