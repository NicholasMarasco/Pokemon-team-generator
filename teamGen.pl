#!/usr/bin/perl

# Perl script to generate random pokemon team from a given list

use strict;
use File::Basename;

# Usage variables
my $cmd = basename($0);
my $usage = "usage: $cmd <number-of-teams> <data-file>\n";

# Check for formatting
die "$usage\n" if(@ARGV != 2);

# Team size parameter sanity check
my $teamNum = $ARGV[0];
die "$usage\nInvalid number of teams: $teamNum\n" if $teamNum =~ /\D+/;

# Check if file exists and is readable
my $datafile = $ARGV[1];
die "No such file exists: $datafile\n" if(! -e $datafile);
open(FILE, '<',$datafile) or die "Cannot open file for reading: $datafile";

print "We good.\n";
close FILE;
