#!/usr/bin/env perl

use strict;
use warnings;

use Module::Build;

my $build = Module::Build->new(
  perl_version  => '5.014',
  module_name   => 'Mind Flayer',
  dist_version  => '0.1',
  dist_author   => 'Sérgio Bernardino <me@sergiobernardino.net>',
  dist_abstract => 'Mind Flayer is a simple web app that "eats" brain matter in the shape of parsable IRC logs',
  license       => 'mit',
  requires      => {
    'Mojolicious'                 => 3.40,
    'DateTime'                    => 0.7,
    'Regexp::Grammars'            => 1,
    'DBIx::Class'                 => 0.08,
    'DBIx::Class::Schema::Loader' => 0.07,
  },
  build_requires      => { 'Test::More'     => 0 },
  configure_requires  => { 'Module::Build'  => 0 },
  add_to_cleanup      => [ '*META.*'   ],
);

$build->create_build_script;

