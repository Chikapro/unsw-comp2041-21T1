#!/bin/dash
./girt-init
touch a b c d e
# invalid arguments
./girt-merge a a a a a a a
./girt-add a
./girt-commit -m commit1
./girt-branch new1
./girt-checkout new1
./girt-add b c d e
./girt-commit -m commit2
./girt-checkout master
./girt-merge new1 -m "message"
rm a b c d e
rm -rf .girt