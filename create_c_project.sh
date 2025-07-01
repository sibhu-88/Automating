#!/bin/bash

# Project name (passed as an argument)
PROJECT_NAME=$1

# Check if project name is provided
if [ -z "$PROJECT_NAME" ]; then
  echo "Usage: $0 <project_name>"
  exit 1
fi

# Create directories
mkdir -p "$PROJECT_NAME"/{src,include,build,lib,tests}

# Create files
touch "$PROJECT_NAME"/src/main.c
touch "$PROJECT_NAME"/include/utils.h
touch "$PROJECT_NAME"/README.md
touch "$PROJECT_NAME"/.gitignore

# Create a basic Makefile
cat << 'EOF' > "$PROJECT_NAME/Makefile"
# Compiler
CC = gcc

# Directories
SRC_DIR = src
INC_DIR = include
BUILD_DIR = build

# Source and object files
SRC_FILES = $(wildcard $(SRC_DIR)/*.c)
OBJ_FILES = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(SRC_FILES))
TARGET = $(BUILD_DIR)/my_program

# Compiler flags
CFLAGS = -I$(INC_DIR) -Wall -Wextra -std=c11

# Default target
all: $(TARGET)

# Link object files into executable
$(TARGET): $(OBJ_FILES)
	@mkdir -p $(BUILD_DIR)
	$(CC) $(OBJ_FILES) -o $(TARGET)

# Compile each .c file to .o
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Clean compiled files
clean:
	rm -rf $(BUILD_DIR)

# Run the compiled program
run: all
	$(TARGET)
EOF

echo "C project '$PROJECT_NAME' created successfully with a basic Makefile."
