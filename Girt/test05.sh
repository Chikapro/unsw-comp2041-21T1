#!/bin/dash
./girt-init
touch a b c d e f g
./girt-add a b c d e f g
# file not exist
./girt-rm h
# file not committed
./girt-rm a b c
echo "hahaha" > a
./girt-rm a
./girt-commit -m "first commit"
# file changed
./girt-rm a
./girt-rm --cached a
./girt-status
./girt-rm --force --cached b c d e f g
./girt-status
rm a b c d e f g
rm -rf .girt

