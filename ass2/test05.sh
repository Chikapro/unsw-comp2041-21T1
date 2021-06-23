#!/bin/dash

# test -f option and input file
file1="my_program.txt"
file2="correct_answer.txt"

seq 4 340 > a.txt
seq 3 394 > b.txt


echo /7/d > commands.input

./speed.pl -f commands.input a.txt b.txt >> $file1
2041 speed -f commands.input a.txt b.txt >> $file2

echo /7/q > commands.input

./speed.pl -f commands.input a.txt b.txt >> $file1
2041 speed -f commands.input a.txt b.txt >> $file2

echo /7/p > commands.input

./speed.pl -f commands.input a.txt b.txt >> $file1
2041 speed -f commands.input a.txt b.txt >> $file2

echo /7/s/[1-5]/bbdd/g > commands.input

./speed.pl -f commands.input a.txt b.txt >> $file1
2041 speed -f commands.input a.txt b.txt >> $file2

rm commands.input a.txt b.txt
if diff "$file1" "$file2" >/dev/null
then
    echo "Test on -f and input file succeeds"
    rm "$file2"
    rm "$file1"
    exit 0
else
    echo "Test on -f and input file fails"
    rm "$file1"
    rm "$file2"
    exit 1
fi