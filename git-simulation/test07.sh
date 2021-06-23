#!/bin/dash
./girt-init
touch a b c d
./girt-add a b c d
# before first commit
./girt-branch
./girt-commit -m commit1
./girt-branch
./girt-branch new1
# exists
./girt-branch new1
./girt-branch new2
./girt-branch
./girt-branch -d new2
./girt-checkout new1
./girt-branch -d master
# doesn't exist
./girt-branch -d new3
touch e
./girt-add e
./girt-commit -m commit2
./girt-checkout master
# unmerged changes
./girt-branch -d new1

rm a b c d e
rm -rf .girt