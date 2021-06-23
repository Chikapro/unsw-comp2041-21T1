#!/bin/dash
# test print command
file1="my_program.txt"
file2="correct_answer.txt"


seq 1 10 | ./speed.pl 4p >> $file1
seq 1 10 | 2041 speed 4p >> $file2

seq 1 20 | ./speed.pl p >> $file1
seq 1 20 | 2041 speed p >> $file2

seq 100 115 | ./speed.pl '/1.1/p' >> $file1
seq 100 115 | 2041 speed '/1.1/p' >> $file2


seq 1 1000 | ./speed.pl -n '10p' >> $file1
seq 1 1000 | 2041 speed -n '10p' >> $file2


seq 3 115 | ./speed.pl -n '$p' >> $file1
seq 3 115 | 2041 speed -n '$p' >> $file2


if diff "$file1" "$file2" >/dev/null
then
    echo "Test on print command succeeds"
    rm "$file2"
    rm "$file1"
    exit 0
else
    echo "Test on print command fails"
    rm "$file1"
    rm "$file2"
    exit 1
fi
