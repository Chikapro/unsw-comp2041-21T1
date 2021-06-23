#!/bin/dash

touch a
# no .girt directory
./girt-add a
./girt-init
touch b c d e f
./girt-add a b c d e f
# unknown name
./girt-add another
rm a
./girt-add a
echo hahaha > b
./girt-add b
./girt-status
rm b c d e f
rm -rf .girt