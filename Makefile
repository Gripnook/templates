CXX := clang++
CXXFLAGS := -std=c++14 -stdlib=libc++ -O -Wall

BIN := app
BUILD_DIR := ./build
SRCS := $(wildcard *.cpp)
OBJS := $(SRCS:%.cpp=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

all: $(BIN)
	$(BUILD_DIR)/$(BIN)

$(BIN): $(BUILD_DIR)/$(BIN)

$(BUILD_DIR)/$(BIN): $(OBJS)
	mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $^ -o $@

-include $(DEPS)

$(BUILD_DIR)/%.o: %.cpp
	mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -MMD -c $< -o $@

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)/$(BIN) $(OBJS) $(DEPS)
