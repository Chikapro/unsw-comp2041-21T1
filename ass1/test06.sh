#!/bin/dash
./girt-init
touch a b c d e f g h i j k l m n
./girt-add a b c d e f g h
./girt-commit -m 'commit1'
echo wryyyyy > a
echo wryyyyy > b
echo wryyyyy > c
echo wryyyyy > d
./girt-add i j k l
echo wryyy > i
rm j
./girt-add a b
echo ohohohoh > a
rm d
./girt-rm e f
./girt-status
rm a b c g h i k l m n
rm -rf .girt