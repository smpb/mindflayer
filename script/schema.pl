#!/usr/bin/env perl

#
# (re)generate the DBIx:Class schema classes
#

use 5.014;
use warnings;

use DBIx::Class::Schema::Loader 'make_schema_at';
use File::Basename 'dirname';
use File::Spec;
use Getopt::Long;

# vars

my $db;
my $dir = join '/', File::Spec->splitdir(dirname __FILE__), '..', 'lib';

# main

GetOptions('db=s' => \$db, 'dir=s' => \$dir);
die 'Incomplete number of arguments' unless (defined $db and defined $dir);

make_schema_at(
  'ElderBrain',
  {
    generate_pod        => 0,
    dump_directory      => $dir,
    result_namespace    => '+ElderBrain',
    resultset_namespace => 'Cortex',
  },
  [ "dbi:SQLite:$db" ],
);

