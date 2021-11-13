#!/bin/dash

# test substitute command
file1="my_program.txt"
file2="correct_answer.txt"


seq 1 10 | ./speed.pl '4s/[1-5]/bbdd/' >> $file1
seq 1 10 | 2041 speed '4s/[1-5]/bbdd/' >> $file2

seq 1 20 | ./speed.pl 's/[1-5]/bbdd/g' >> $file1
seq 1 20 | 2041 speed 's/[1-5]/bbdd/g' >> $file2

seq 100 115 | ./speed.pl '/1.1/s/[1-5]/bbdd/g' >> $file1
seq 100 115 | 2041 speed '/1.1/s/[1-5]/bbdd/g' >> $file2


seq 3 115 | ./speed.pl '$s/[1-5]/bbdd/g' >> $file1
seq 3 115 | 2041 speed '$s/[1-5]/bbdd/g' >> $file2

seq 1 1000 | ./speed.pl -n '10s/[1-5]/bbdd/g' >> $file1
seq 1 1000 | 2041 speed -n '10s/[1-5]/bbdd/g' >> $file2

seq 2 20 | ./speed.pl 'sB[27]BooooB' >> $file1
seq 2 20 | 2041 speed 'sB[27]BooooB' >> $file2

if diff "$file1" "$file2" >/dev/null
then
    echo "Test on substitute command succeeds"
    rm "$file2"
    rm "$file1"
    exit 0
else
    echo "Test on substitute command fails"
    rm "$file1"
    rm "$file2"
    exit 1
fi
