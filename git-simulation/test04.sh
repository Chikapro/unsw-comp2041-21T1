#!/bin/dash
./girt-init
echo "my war" > a
./girt-add a
./girt-commit -m 'commit1'
# invalid object
./girt-show 123
# unknow commit number
./girt-show 3:a
# unknow name
./girt-show 0:d
./girt-show 0:a
echo "another" >> a
./girt-add a
# unknow name
./girt-show :d
./girt-show :a
./girt-commit -m 'commit2'
./girt-show 0:a
./girt-show 1:a
rm a
rm -rf .girt