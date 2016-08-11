#!/usr/bin/perl

# Perl script to generate random pokemon team from a given list

use strict;
use File::Basename;
use Getopt::Long;
Getopt::Long::Configure ("bundling");

# Constants
my $TEAMSIZE = 10;

# Usage variables
my $cmd = basename($0);
my $options = "\nOptions:\n".
              "   -h, --help    Display this screen and exit\n".
              "   -d, --debug   Increase debug information and warning level\n";
my $usage = "usage: $cmd [-hd] <number-of-teams> <data-file>\n".$options;

# Option variables
my $help = 0;
my $debug = 0;

my $result = GetOptions(
  "h|help|usage" => \$help,  # print help and exit
  "d|debug+"     => \$debug, # print debug info
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

# Process file and get hash of number to name
my %mons;
while(<FILE>){
  chomp;
  next if /^\s*#/;
  next if /^\s*$/;
  my @line = split/:/;
  $mons{$line[0]}=$line[1];
  print "$line[0] => $line[1]\n" if $debug > 1;
}
close FILE;
my $monNum = keys %mons;
print "monNum: $monNum\n" if $debug;

# Check for unique team composition
my $unique = 1;
if ($teamNum*$TEAMSIZE > $monNum) {
  warn "Warning: Too many teams for unique compositions\n";
  $unique = 0;
}

# Gen the teams
my %teams;
for(my $i = 1; $i <= $teamNum; $i++){
  my @team;
  for (1..$TEAMSIZE){
    my $index;
    until (exists $mons{$index}){
      $index = int(rand($monNum));
    }
    push @team,$mons{$index};
    delete $mons{$index} if $unique;
  }
  print "team: @team\n" if $debug;
  $teams{$i}=[@team];
}

print "\nPlayer: $_ =>\nTeam: @{$teams{$_}}\n" foreach(sort{$a <=> $b}keys %teams);

print "\nWe good.\n";
