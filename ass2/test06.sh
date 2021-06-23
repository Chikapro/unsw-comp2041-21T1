#!/bin/dash

# check comment and space and multiple commands
file1="my_program.txt"
file2="correct_answer.txt"

seq 1 1000 | ./speed.pl '/4/p;9q' >> $file1
seq 1 1000 | 2041 speed '/4/p;9q' >> $file2

seq 1 1000| ./speed.pl '/9/p # print df  ;  4  d #   delete df' >> $file1
seq 1 1000| 2041 speed '/9/p # print df  ;  4  d #   delete df' >> $file2

if diff "$file1" "$file2" >/dev/null
then
    echo "Test on comment and space and multiple commands succeeds"
    rm "$file2"
    rm "$file1"
    exit 0
else
    echo "Test on comment and space and multiple commands fails"
    rm "$file1"
    rm "$file2"
    exit 1
fi