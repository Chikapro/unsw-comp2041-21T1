#!/bin/dash

# test comma
file1="my_program.txt"
file2="correct_answer.txt"

seq 1 1023 | ./speed.pl '40,89d' >> $file1
seq 1 1023 | 2041 speed '40,89d' >> $file2


seq 1 1023 | ./speed.pl '40,/2/d' >> $file1
seq 1 1023 | 2041 speed '40,/2/d' >> $file2


seq 1 1023 | ./speed.pl '/2/,40d' >> $file1
seq 1 1023 | 2041 speed '/2/,40d' >> $file2



seq 1 1023 | ./speed.pl '/1/,/2/d' >> $file1
seq 1 1023 | 2041 speed '/1/,/2/d' >> $file2


seq 1 1023 | ./speed.pl '40,89p' >> $file1
seq 1 1023 | 2041 speed '40,89p' >> $file2


seq 1 1023 | ./speed.pl '40,/2/p' >> $file1
seq 1 1023 | 2041 speed '40,/2/p' >> $file2


seq 1 1023 | ./speed.pl '/2/,40p' >> $file1
seq 1 1023 | 2041 speed '/2/,40p' >> $file2



seq 1 1023 | ./speed.pl '/1/,/2/p' >> $file1
seq 1 1023 | 2041 speed '/1/,/2/p' >> $file2


seq 1 1023 | ./speed.pl '40,89s/[1-5]/bbdd/g' >> $file1
seq 1 1023 | 2041 speed '40,89s/[1-5]/bbdd/g' >> $file2


seq 1 1023 | ./speed.pl '40,/2/s/[1-5]/bbdd/g' >> $file1
seq 1 1023 | 2041 speed '40,/2/s/[1-5]/bbdd/g' >> $file2


seq 1 1023 | ./speed.pl '/2/,40s/[1-5]/bbdd/g' >> $file1
seq 1 1023 | 2041 speed '/2/,40s/[1-5]/bbdd/g' >> $file2



seq 1 1023 | ./speed.pl '/1/,/2/s/[1-5]/bbdd/g' >> $file1
seq 1 1023 | 2041 speed '/1/,/2/s/[1-5]/bbdd/g' >> $file2


if diff "$file1" "$file2" >/dev/null
then
    echo "Test on comma succeeds"
    rm "$file2"
    rm "$file1"
    exit 0
else
    echo "Test on comma fails"
    rm "$file1"
    rm "$file2"
    exit 1
fi