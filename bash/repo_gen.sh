#!/bin/bash

### Script has now been tested and is fully functional :3 Happy coding 

if [ -z "$1" ]; then
    echo "Usage: $0 <project_name>"
    exit 1
fi

repoDir="$HOME/Repos"
mkdir -p "$repoDir"
echo "$repoDir is ready."

projectName="$1"
projectPath="$repoDir/$projectName"

# Ensure uniqueness
if [ -d "$projectPath" ]; then
    echo "Project '$projectName' already exists!"
    exit 1
fi

# Create structure
mkdir -p "$projectPath"/{src,build,include,docs}

#make some starter files for cmake
cat > "$projectPath/CMakeLists.txt" <<EOF
cmake_minimum_required(VERSION 3.10)

project($projectName)

set(CMAKE_CXX_STANDARD 17)

# Add source files
add_executable($projectName src/main.cpp)

# Include directories
include_directories(include)
EOF

cat > "$projectPath/src/main.cpp" <<EOF
#include <iostream>

int main() {
    std::cout << "Hello, $projectName!" << std::endl;
    return 0;
}
EOF


touch "$projectPath/README.md"
echo "# $projectName" > "$projectPath/README.md"

echo "Project $projectName created at $projectPath"

# Open in VSCodium fallback on nano
cd "$projectPath/build" || exit 1
cmake .. -G Ninja  # This tells CMake to use Ninja for the build system

# Build the project with Ninja
ninja


if ! command -v codium &> /dev/null; then
    echo "VSCodium not found. navigating to the project directory..."
    cd "$projectPath" || exit 1
else
    codium "$projectPath"
fi
