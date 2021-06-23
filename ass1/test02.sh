#!/bin/dash
./girt-init
touch a b c d e f
./girt-add a b c d e f
./girt-commit -m commit1
touch g
./girt-add g
./girt-commit -m commit2
touch h i j k
./girt-commit -a -m commit3
./girt-log
rm a b c d e f g h i j k
rm -rf .girt