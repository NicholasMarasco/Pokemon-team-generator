#!/usr/bin/perl -w

# Perl script to generate random pokemon team from a given list

use strict;
use File::Basename;
use Getopt::Long;

# Usage variables
my $cmd = basename($0);
my $options = " options:\n".
              "   -d, --debug   Displays debug information and warnings\n";
my $usage = "usage: $cmd [-d] <number-of-teams> <data-file>\n".$options;

# Option variables
my $help = 0;
my $debug = 0;

my $result = GetOptions(
  "help|usage" => \$help,  # print help and exit
  "debug"      => \$debug, # print debug info
  );

# Check for formatting or help
die "$usage\n" if(@ARGV != 2
                  or !$result
                  or $help
                 );

# Team size parameter sanity check
my $teamNum = $ARGV[0];
print "teamNum: $teamNum\n" if $debug;
die "Invalid number of teams: $teamNum\n" if $teamNum =~ /\D+/;

# Check if file exists and is readable
my $datafile = $ARGV[1];
print "datafile: $datafile\n" if $debug;
die "No such file exists: $datafile\n" if(! -e $datafile);
open(FILE, '<',$datafile) or die "Cannot open file for reading: $datafile";

print "We good.\n";
close FILE;
