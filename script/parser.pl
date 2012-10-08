#!/usr/bin/env perl

#
# log parser
#

use 5.014;
use warnings;

use Getopt::Long;
use Data::Dumper;
use Regexp::Grammars;

# vars

my $grammar;
my $log;

# main

GetOptions("grammar=s" => \$grammar, "log=s" => \$log);
die "Incomplete number of arguments" unless (defined $grammar and defined $log);

open my $fh, '<', $grammar or die $!; 
my $spec = do { local $/; <$fh> };
close $fh;

my $parser = eval "qr{ $spec }x";

open $fh, '<', $log or die $!;

while (my $line = <$fh>)
{
  if ($line =~ $parser)
  {
    say "$line";
    say Dumper \%/;
  }
  else
  {
    say "FAIL: $line";
  }
}

close $fh;
