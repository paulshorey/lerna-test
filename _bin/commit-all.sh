#!/bin/bash
# Optionally, make this file executable: chmod +x recursive_iteration.sh
# Or call it with: bash recursive_iteration.sh
cwd=$( cd "$(dirname "$0")" ; pwd -P )
echo $cwd
rootdir=$cwd/../

# Function to be called for each directory
function process_dir {
  # $1 is the directory passed as an argument to the function
  # Make sure the input is a relative path
  if [[ $1 == /* ]]; then
    echo "Error: Input must be a relative path."
    return 1
  fi
  # Only process submodules
  if [ ! -f "$1/lerna.json" ]; then
    if [ -d "$1/.git" ]; then
      echo -e "\n\033[0;33mAttempting to commit changes in \033[0m" "\033[0;32m$1\033[0m"
      cd "$rootdir$1"
      git add .
      git pull
      git add .
      git commit -m "$2"
      git push
      cd $rootdir
    fi
  fi
}

# Input directory
input_dir=$1
commit_message=$2
# echo -e "\033[0;31minput_dir= $input_dir\033[0m"
# echo -e "\033[0;31mcommit_message= $commit_message\033[0m"

# Recursively iterate through every subdirectory in the input directory
for dir in $(find "$input_dir" -maxdepth 2 -type d ! -path "*node_modules*" ! -path "*node_modules_x*"); do
  process_dir "$dir" "$commit_message"
done