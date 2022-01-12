#!/bin/bash
echo "######################"
echo "    Build Process"
echo "######################"
# list current folder
pwd
#####################
## invoke compiler ##
#####################

echo "Nothing for Nodejs"

# mkdir bin folder
# copy runtime to bin folder to be published
mkdir ../bin
#
# copy runtime
#
cp -r ../src/* ../bin

echo "Build Completed."
#read -p "Press [Enter] key to start build process..."

