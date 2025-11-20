#!/bin/bash
set -e

# Check for project name argument
if [ -z "$1" ]; then
    echo "Usage: $0 <ProjectName>"
    exit 1
fi

# Project name
PROJECT_NAME="$1"

# Base project directory
PROJECT_DIR="$PROJECT_NAME"

# Directories
SRC_DIR="$PROJECT_DIR/src"
INCLUDE_DIR="$PROJECT_DIR/include"
BUILD_DEBUG_DIR="$PROJECT_DIR/build-debug"
BUILD_RELEASE_DIR="$PROJECT_DIR/build-release"
VSCODE_DIR="$PROJECT_DIR/.vscode"

# Create directory structure
mkdir -p "$SRC_DIR" "$INCLUDE_DIR" "$VSCODE_DIR" "$BUILD_DEBUG_DIR" "$BUILD_RELEASE_DIR"

# Create CMakeLists.txt
cat > "$PROJECT_DIR/CMakeLists.txt" <<EOL
cmake_minimum_required(VERSION 3.16)
project($PROJECT_NAME VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Recursively gather all .cpp files in src/
file(GLOB_RECURSE CORE_SOURCES src/*.cpp)

# Create the library
add_library(${PROJECT_NAME}Core STATIC \${CORE_SOURCES})

# Add include directories
target_include_directories(${PROJECT_NAME}Core PUBLIC \${PROJECT_SOURCE_DIR}/include)

# Set C++ standard
target_compile_features(${PROJECT_NAME}Core PUBLIC cxx_std_20)

# Create executable
add_executable($PROJECT_NAME src/main.cpp)

# Link library to executable
target_link_libraries($PROJECT_NAME PRIVATE ${PROJECT_NAME}Core)
EOL

# Create main.cpp
cat > "$SRC_DIR/main.cpp" <<EOL
#include <stdio.h>

int main() {
    printf("Welcome to $PROJECT_NAME\\n");
    printf("Hello World!\\n");
}
EOL

# Generate build systems using Ninja
cmake -S "$PROJECT_DIR" -B "$BUILD_DEBUG_DIR" -G Ninja -DCMAKE_BUILD_TYPE=Debug
cmake -S "$PROJECT_DIR" -B "$BUILD_RELEASE_DIR" -G Ninja -DCMAKE_BUILD_TYPE=Release

# Create symlink for compile_commands.json (from debug build)
ln -sf "../build-debug/compile_commands.json" "$PROJECT_DIR/compile_commands.json"

# Create VSCode C++ configuration
cat > "$VSCODE_DIR/c_cpp_properties.json" <<EOL
{
    "configurations": [
        {
            "name": "Linux",
            "compileCommands": "\${workspaceFolder}/compile_commands.json",
            "cppStandard": "c++20",
            "intelliSenseMode": "linux-clang-x64"
        }
    ],
    "version": 4
}
EOL

# Create VSCode launch configuration
cat > "$VSCODE_DIR/launch.json" <<EOL
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "C/C++ Debug (gdb Launch)",
      "type": "cppdbg",
      "request": "launch",
      "program": "\${workspaceFolder}/build-debug/$PROJECT_NAME",
      "args": [],
      "stopAtEntry": false,
      "cwd": "\${workspaceFolder}",
      "environment": [],
      "MIMode": "gdb",
      "setupCommands": [
        {
          "description": "Enable pretty-printing for gdb",
          "text": "-enable-pretty-printing",
          "ignoreFailures": true
        }
      ]
    }
  ]
}
EOL

# Create VSCode settings.json
cat > "$VSCODE_DIR/settings.json" <<EOL
{
    "cmake.buildDirectory": "\${workspaceFolder}/build-debug",
    "cmake.configureSettings": {
        "CMAKE_BUILD_TYPE": "Debug"
    }
}
EOL

# Create .gitignore
cat > "$PROJECT_DIR/.gitignore" <<EOL
/build/
/CMakeCache.txt
/CMakeFiles/
/Makefile
/build.ninja
/*.ninja
/*.swp
/.cache
compile_commands.json
/build-debug/
/build-release/

# Compiled binaries
*.out
*.exe
*.o
*.obj
*.so
*.a
*.dylib

# Editor files
.vscode/
.vscode-codium/
*.code-workspace
EOL

git -C "$PROJECT_DIR" init

echo "Project $PROJECT_NAME has been created successfully in '$PROJECT_DIR'!"
echo "Build directories (Ninja): $BUILD_DEBUG_DIR, $BUILD_RELEASE_DIR"
echo "VSCode configuration generated in $VSCODE_DIR"
