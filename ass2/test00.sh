#!/bin/dash
# test quit command
file1="my_program.txt"
file2="correct_answer.txt"

seq 1 10 | ./speed.pl 4q >> $file1
seq 1 10 | 2041 speed 4q >> $file2

seq 1 20 | ./speed.pl q >> $file1
seq 1 20 | 2041 speed q >> $file2

seq 100 115 | ./speed.pl '/1.1/q' >> $file1
seq 100 115 | 2041 speed '/1.1/q' >> $file2

seq 3 115 | ./speed.pl '$q' >> $file1
seq 3 115 | 2041 speed '$q' >> $file2

seq 1 1000 | ./speed.pl -n '10q' >> $file1
seq 1 1000 | 2041 speed -n '10q' >> $file2

if diff "$file1" "$file2" >/dev/null
then
    echo "Test on quit command succeeds"
    rm "$file2"
    rm "$file1"
    exit 0
else
    echo "Test on quit command fails"
    rm "$file1"
    rm "$file2"
    exit 1
fi

