#!/bin/dash
./girt-init
touch a b c d e f g
./girt-add a b c
./girt-commit -m "commit1"
./girt-add d e
./girt-commit -m "commit2"
./girt-add f g
./girt-commit -m "commit3"
./girt-log
rm a b c d e f g
rm -rf .girt