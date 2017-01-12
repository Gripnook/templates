CXX := clang++
CXXFLAGS := -std=c++14 -stdlib=libc++ -O -Wall

BIN := app
BUILD_DIR := ./build
SRCS := $(wildcard *.cpp)
OBJS := $(SRCS:%.cpp=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

all: $(BIN)

$(BIN): $(BUILD_DIR) $(BUILD_DIR)/$(BIN)

$(BUILD_DIR):
	mkdir -p $@

$(BUILD_DIR)/$(BIN): $(OBJS)
	$(CXX) $(CXXFLAGS) $^ -o $@

-include $(DEPS)

$(BUILD_DIR)/%.o: %.cpp
	$(CXX) $(CXXFLAGS) -MMD -c $< -o $@

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)/$(BIN) $(OBJS) $(DEPS)
