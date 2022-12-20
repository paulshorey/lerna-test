#!/bin/bash
# Optionally, make this file executable: chmod +x recursive_iteration.sh
# Or call it with: bash recursive_iteration.sh

# Function to be called for each directory
function process_dir {
  # $1 is the directory passed as an argument to the function
  if [ -d "$1/.git" ]; then
    echo "Committing any changes in $1"
    git add .
    git pull 
    git commit -m "$2"
    git push
  fi
}

# Input directory
input_dir=$1
commit_message=$2

# Recursively iterate through every subdirectory in the input directory
for dir in $(find "$input_dir" -maxdepth 2 -type d ! -path "*node_modules*" ! -path "*node_modules_x*"); do
  # Call the function for each directory
  process_dir "$dir" "$commit_message"
done