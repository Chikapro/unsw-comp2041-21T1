#!/bin/dash

# already a directory
mkdir ".girt"
./girt-init
rm -d ".girt"
./girt-init
for dir in .*/
do
    echo $dir
done
rm -rf ".girt"