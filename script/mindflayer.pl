#!/usr/bin/env perl

use 5.014;
use warnings;

use Mojo::Base;

use File::Basename 'dirname';
use File::Spec;

use lib join '/', File::Spec->splitdir(dirname(__FILE__)), '..', 'lib';

# we need Mojolicious
die 'Mojolicious framework required.' unless eval 'use Mojolicious::Commands; 1';

# start the app
$ENV{MOJO_APP} ||= 'MindFlayer';
Mojolicious::Commands->start();

