#!/usr/bin/perl -w

# Check the options in arguments (-i -n -f)
if ($#ARGV + 1 == 0 || $ARGV[0] eq '--help') {
    print "usage: speed.pl [-i] [-n] [-f <script-file> | <sed-command>] [<files>...]\n";
    exit 0;
}
$replace_file = 0;
$stop_print = 0;
$command_file = 0;
foreach $arg (@ARGV) {
    # replaces file contents with the output of the Speed commands
    if ($arg eq "-i") {
        $replace_file = 1;
    }
    # stops input lines being printed by default.
    if ($arg eq "-n") {
        $stop_print = 1;
    }
    # reads Speed commands from the specified file
    if ($arg eq "-f") {
        $command_file = 1;
    }
}

# causes speed.pl to exit
sub quit_command {
    if ($address =~ /^\d+$/) {
        # line number
        if (!$stop_print) {
            print $line;
        }
        if ($address == $i) {
            exit 0;
        }
    } elsif ($address eq "") {
        # empty string
        if (!$stop_print) {
            print $line;
        }
        exit 0;
    } elsif ($address eq '$') {
        # last line
        if (!$stop_print) {
            print $line;
        }
    } else {
        # match regex
        if (!$stop_print) {
            print $line;
        }
        $address =~ /\/(.*)\//;
        $address = $1;
        if ($line =~ /$address/) {
            exit 0;
        }
    }
}

# prints the input line
sub print_command {
    # Check if comma exists in command
    if ($address =~ /^(\/.*?\/|[0-9]*),(\/.*?\/|[0-9]*)$/) {
        $start = $1;
        $last = $2;
        if (!$comma_separater{"$start"}) {
            # search the address at start
            $comma_separater{"$start"} = "no";
            $address = $start;
        } elsif ($comma_separater{"$start"} eq "yes") {
            # search the address at last
            $address = $last;
        } elsif ($comma_separater{"$start"} eq "no") {
            # search the address at start
            $address = $start;
        }
    }
    if ($address =~ /^\d+$/) {
        # line number
        if (!$stop_print) {
            print $line;
        }
        if ($address == $i) {
            print $line;
            if ($start && $comma_separater{"$start"} &&
                    $comma_separater{"$start"} eq "no") {
                # the address at start is found
                $comma_separater{"$start"} = "yes";
            } elsif ($start && $comma_separater{"$start"} &&
                    $comma_separater{"$start"} eq "yes") {
                # the address at last is found
                $comma_separater{"$start"} = "no";
            }
        } elsif ($start && $comma_separater{"$start"} &&
                $comma_separater{"$start"} eq "yes") {
            # in the middle of two addresses
            print $line;
        }
    } elsif ($address eq "") {
        # empty string
        if (!$stop_print) {
            print $line;
        }
        print $line;
    } elsif ($address eq '$') {
        # last line
        if (!$stop_print) {
            print $line;
        }
        $prev_line = $line;
        if ($file eq "nofile") {
            $line = <STDIN>;
        } else {
            $line = <$in>;
        }
        # if next line doesn't exist then this is the last line
        if (!$line) {
            print $prev_line;
            exit 0;
        } else {
            $if_read = 0;
        }
    } else {
        # match regex
        if (!$stop_print) {
            print $line;
        }
        $address =~ /\/(.*)\//;
        $address = $1;
        if ($line =~ /$address/) {
            print $line;
            if ($start && $comma_separater{"$start"} &&
                    $comma_separater{"$start"} eq "no") {
                # the address at start is found
                $comma_separater{"$start"} = "yes";
            } elsif ($start && $comma_separater{"$start"} &&
                    $comma_separater{"$start"} eq "yes") {
                # the address at last is found
                $comma_separater{"$start"} = "no";
            }
        } elsif ($start && $comma_separater{"$start"} &&
                $comma_separater{"$start"} eq "yes") {
            # in the middle of two addresses
            print $line;
        }
    }
}

# deletes the input line by not printing the selected line
sub delete_command {
    # Check if comma exists in command
    if ($address =~ /^(\/.*?\/|[0-9]*),(\/.*?\/|[0-9]*)$/) {
        $start = $1;
        $last = $2;
        if (!$comma_separater{"$start"}) {
            # search the address at start
            $comma_separater{"$start"} = "no";
            $address = $start;
        } elsif ($comma_separater{"$start"} eq "yes") {
            # search the address at last
            $address = $last;
        } elsif ($comma_separater{"$start"} eq "no") {
            $address = $start;
        }
    }
    if ($address =~ /^\d+$/) {
        # line number
        if ($address == $i) {
            if ($start && $comma_separater{"$start"} &&
                    $comma_separater{"$start"} eq "no") {
                # the address at start is found
                $comma_separater{"$start"} = "yes";
            } elsif ($start && $comma_separater{"$start"} &&
                    $comma_separater{"$start"} eq "yes") {
                # the address at last is found
                $comma_separater{"$start"} = "no";
            }
        }
        if ($start && $comma_separater{"$start"} &&
                $comma_separater{"$start"} eq "yes") {
            # don't print
        } elsif ($address != $i && !$stop_print) {
            print $line;
        }
    } elsif ($address eq "") {
        #don't print
    } elsif ($address eq '$') {
        # last line
        $prev_line = $line;
        if ($file eq "nofile") {
            $line = <STDIN>;
        } else {
            $line = <$in>;
        }
        # if next line doesn't exist then this is the last line
        if (!$line) {
            exit 0;
        } else {
            if (!$stop_print) {
                print $prev_line;
            }
            $if_read = 0;
        }
    } else {
        # match regex
        $address =~ /\/(.*)\//;
        $address = $1;
        if ($line =~ /$address/) {
            if ($start && $comma_separater{"$start"} &&
                    $comma_separater{"$start"} eq "no") {
                # the address at start is found
                $comma_separater{"$start"} = "yes";
            } elsif ($start && $comma_separater{"$start"} &&
                    $comma_separater{"$start"} eq "yes") {
                # the address at last is found
                $comma_separater{"$start"} = "no";
            }
        } elsif ($start && $comma_separater{"$start"} &&
                $comma_separater{"$start"} eq "yes") {
            # don't print
        } elsif (!$stop_print) {
            print $line;
        }
    }
}


# replaces the specified regex on the input line
sub substitute_command {
    # Check if comma exists in command
    if ($address =~ /^(\/.*?\/|[0-9]*),(\/.*?\/|[0-9]*)$/) {
        $start = $1;
        $last = $2;
        if (!$comma_separater{"$start"}) {
            $comma_separater{"$start"} = "no";
            $address = $start;
        } elsif ($comma_separater{"$start"} eq "yes") {
            # search the address at last
            $address = $last;
        } elsif ($comma_separater{"$start"} eq "no") {
            # search the address at start
            $address = $start;
        }
    }
    # $tmp is the string after s character
    # find delimiter
    $tmp =~ /^(.)/;
    $delimiter = $1;
    if ($tmp =~ /g$/) {
        # replace all the string that appeares
        $replace_all = 1;
        $tmp =~ /^$delimiter(.*)$delimiter(.*)($delimiter)g$/;
        $original = $1;
        $replace = $2;
    } else {
        # replace the first string
        $tmp =~ /^$delimiter(.*)$delimiter(.*)$delimiter$/;
        $original = $1;
        $replace = $2;
        $replace_all = 0;
    }
    # Address
    if ($address =~ /^\d+$/) {
        # line number
        if ($address == $i) {
            if ($replace_all){
                $line =~ s/$original/$replace/g;
            } else {
                $line =~ s/$original/$replace/;
            }
            if ($start && $comma_separater{"$start"} &&
                    $comma_separater{"$start"} eq "no") {
                # the address at start is found
                $comma_separater{"$start"} = "yes";
            } elsif ($start && $comma_separater{"$start"} &&
                    $comma_separater{"$start"} eq "yes") {
                # the address at last is found
                $comma_separater{"$start"} = "no";
            }
        } elsif ($start && $comma_separater{"$start"} &&
                $comma_separater{"$start"} eq "yes") {
            # in the middle of two addresses
            if ($replace_all){
                $line =~ s/$original/$replace/g;
            } else {
                $line =~ s/$original/$replace/;
            }
        }
        if (!$stop_print) {
            print $line;
        }
    } elsif ($address eq "") {
        if ($replace_all){
            $line =~ s/$original/$replace/g;
        } else {
            $line =~ s/$original/$replace/;
        }
        if (!$stop_print) {
            print $line;
        }
    } elsif ($address eq '$') {
        # last line
        $prev_line = $line;
        if ($file eq "nofile") {
            $line = <STDIN>;
        } else {
            $line = <$in>;
        }
        # if next line doesn't exist then this is the last line
        if (!$line) {
            if ($replace_all){
                $prev_line =~ s/$original/$replace/g;
            } else {
                $prev_line =~ s/$original/$replace/;
            }
            if (!$stop_print) {
                print $prev_line;
            }
            exit 0;
        } else {
            if (!$stop_print) {
                print $prev_line;
            }
            # stop reading new line
            $if_read = 0;
        }
    } else {
        # match regex
        $address =~ /\/(.*)\//;
        $address = $1;
        if ($line =~ /$address/) {
            if ($replace_all){
                $line =~ s/$original/$replace/g;
            } else {
                $line =~ s/$original/$replace/;
            }
            if ($start && $comma_separater{"$start"} &&
                    $comma_separater{"$start"} eq "no") {
                $comma_separater{"$start"} = "yes";
            } elsif ($start && $comma_separater{"$start"} &&
                    $comma_separater{"$start"} eq "yes") {
                $comma_separater{"$start"} = "no";
            }
        } elsif ($start && $comma_separater{"$start"} &&
                $comma_separater{"$start"} eq "yes") {
            # in the middle of two addresses
            if ($replace_all){
                $line =~ s/$original/$replace/g;
            } else {
                $line =~ s/$original/$replace/;
            }
        }
        if (!$stop_print) {
            print $line;
        }
    }
}


# Depending on which arguments are used
# Process arguments and store command and files into variables and arrays
if ($replace_file and $stop_print and $command_file) {
    $script_file = $ARGV[3];
    # Read script file
    open my $in, '<', "$script_file" or die "can't open";
    while ($line = <$in>) {
        $command .= $line;
    }
    # input files
    if ($#ARGV != 3) {
        $i = 4;
        while ($i <= $#ARGV) {
            push @files, $ARGV[$i];
            $i++;
        }
    }
} elsif ($replace_file and $stop_print and not $command_file) {
    $command = $ARGV[2];
    # input files
    if ($#ARGV != 2) {
        $i = 3;
        while ($i <= $#ARGV) {
            push @files, $ARGV[$i];
            $i++;
        }
    }
} elsif ($replace_file and not $stop_print and $command_file) {
    $script_file = $ARGV[2];
    # Read script file
    open my $in, '<', "$script_file" or die "can't open";
    while ($line = <$in>) {
        $command .= $line;
    }
    # input files
    if ($#ARGV != 2) {
        $i = 3;
        while ($i <= $#ARGV) {
            push @files, $ARGV[$i];
            $i++;
        }
    }
} elsif ($replace_file and not $stop_print and not $command_file) {
    $command = $ARGV[1];
    # input files
    if ($#ARGV != 1) {
        $i = 2;
        while ($i <= $#ARGV) {
            push @files, $ARGV[$i];
            $i++;
        }
    }
} elsif (not $replace_file and $stop_print and $command_file) {
    $script_file = $ARGV[2];
    # Read script file
    open my $in, '<', "$script_file" or die "can't open";
    while ($line = <$in>) {
        $command .= $line;
    }
    # input files
    if ($#ARGV != 2) {
        $i = 3;
        while ($i <= $#ARGV) {
            push @files, $ARGV[$i];
            $i++;
        }
    }
} elsif (not $replace_file and $stop_print and not $command_file) {
    $command = $ARGV[1];
    # input files
    if ($#ARGV != 1) {
        $i = 2;
        while ($i <= $#ARGV) {
            push @files, $ARGV[$i];
            $i++;
        }
    }
} elsif (not $replace_file and not $stop_print and $command_file) {
    $script_file = $ARGV[1];
    # Read script file
    open my $in, '<', "$script_file" or die "can't open";
    while ($line = <$in>) {
        $command .= $line;
    }
    # input files;
    if ($#ARGV != 1) {
        $i = 2;
        while ($i <= $#ARGV) {
            push @files, $ARGV[$i];
            $i++;
        }
    }
} elsif (not $replace_file and not $stop_print and not $command_file) {
    $command = $ARGV[0];
    # input files
    if ($#ARGV != 0) {
        $i = 1;
        while ($i <= $#ARGV) {
            push @files, $ARGV[$i];
            $i++;
        }
    }
}

# if no input files, use "nofile"
if (!@files) {
    push @files, "nofile";
}


# Process files, all the variables are global
$i = 1; # $i is used to count line numbers
foreach $file (@files) {
    # if no file is used, read from standard input.
    if ($file eq "nofile") {
        $line = <STDIN>;
    } else {
        open $in, '<', "$file" or die "can't open file";
        $line = <$in>;
    }
    # Process each line in order for each file
    while ($line) {
        @commands = split(/;|\n/, $command);
        $if_read = 1;
        # Process each command in order for each line
        foreach $command (@commands) {
            # remove Comments & White Space
            $command =~ s/# .*$//;
            $command =~ s/\s//g;
            if ($command =~ /(.*)q$/) {
                # causes speed.pl to exit
                $address = $1;
                quit_command;
            } elsif ($command =~ /(.*)p$/) {
                # prints the input line
                $address = $1;
                print_command;
            } elsif ($command =~ /(.*)d$/) {
                # deletes the input line,
                $address = $1;
                delete_command;
            } elsif ($command =~ /(.*)s(.*)/) {
                # replaces the specified regex on the input line
                $address = $1;
                $tmp = $2;
                substitute_command;
            }
        }
        $i++;
        # When $ is used as address, $line has already read from input,
        # therefore don't read
        if (!$if_read) {
            next;
        }
        if ($file eq "nofile") {
            $line = <STDIN>;
        } else {
            $line = <$in>;
        }
    }
}


