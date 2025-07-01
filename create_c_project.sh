# create_c_project.sh
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
touch "$PROJECT_NAME"/Makefile
touch "$PROJECT_NAME"/README.md
touch "$PROJECT_NAME"/.gitignore

echo "C project '$PROJECT_NAME' created successfully."

