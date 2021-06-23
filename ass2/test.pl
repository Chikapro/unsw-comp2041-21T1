#!/usr/bin/perl -w
$b = '?';
$seperater =  <<'EOS';
\
EOS
$seperater .= $b;
#print "$b\n";

$seperater =~ s/\s//;
print "$seperater\n";
$a = "?abc?egh?";
$a =~ /^$seperater(.*)$seperater(.*)$seperater/;
print "$1   $2 \n";
