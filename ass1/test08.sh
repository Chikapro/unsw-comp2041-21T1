#!/bin/dash
./girt-init
touch a b c d
./girt-add a b c d
# before first commit
./girt-checkout new
./girt-commit -m commit1
./girt-branch new1
./girt-branch new2
# unknow name
./girt-checkout new3
# Already on
./girt-checkout master
./girt-checkout new1
./girt-checkout new2
rm a b c d
rm -rf .girt