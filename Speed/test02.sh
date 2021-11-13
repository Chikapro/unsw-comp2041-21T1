#!/bin/dash

# test delete command
file1="my_program.txt"
file2="correct_answer.txt"



seq 1 10 | ./speed.pl 4d >> $file1
seq 1 10 | 2041 speed 4d >> $file2

seq 1 20 | ./speed.pl d >> $file1
seq 1 20 | 2041 speed d >> $file2

seq 100 115 | ./speed.pl '/1.1/d' >> $file1
seq 100 115 | 2041 speed '/1.1/d' >> $file2


seq 3 115 | ./speed.pl '$d' >> $file1
seq 3 115 | 2041 speed '$d' >> $file2

seq 1 1000 | ./speed.pl -n '10d' >> $file1
seq 1 1000 | 2041 speed -n '10d' >> $file2


if diff "$file1" "$file2" >/dev/null
then
    echo "Test on delete command succeeds"
    rm "$file2"
    rm "$file1"
    exit 0
else
    echo "Test on delete command fails"
    rm "$file1"
    rm "$file2"
    exit 1
fi
