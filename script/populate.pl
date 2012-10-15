#!/usr/bin/env perl

#
# parse log, populate db
#

use 5.014;
use warnings;

use DateTime;
use Data::Dumper;
use Getopt::Long;
use Regexp::Grammars;

use File::Spec;
use File::Basename 'dirname';

use lib join '/', File::Spec->splitdir(dirname __FILE__), '..', 'lib';
use ElderBrain;

# vars

my $grammar;
my $log;
my $db;

# main

GetOptions("grammar=s" => \$grammar, "log=s" => \$log, "db=s" => \$db);
die "Incomplete number of arguments"
  unless (defined $grammar and defined $log and defined $db);

# parser spec

open my $fh, '<', $grammar or die $!; 
my $spec = lc do { local $/; <$fh> };
close $fh;

my $parser = eval "qr{ $spec }x";

# database

my $dbc = ElderBrain->connect("dbi:SQLite:$db");

# log

open $fh, '<', $log or die $!;

while (my $line = <$fh>)
{
  if ($line =~ $parser)
  {
    say "$line" . Dumper \%/ if $ENV{DEBUG};

    my $dt = DateTime->new( %{ $/{date} } );

    my ( $type ) = grep { $_ ne 'date' } keys %/;
    my $sender = lc $/{$type}{sender};

    my $user;
    my $alias;

    # do we know this nick?
    unless ( $user = $dbc->resultset('User')->find({ nick => $sender }) )
    {
      # is it a variation for a known nick?
      my $s = $sender;
      {
        # Regexp::Grammars is great, but it screws up the regexp engine in such a way
        # that run-of-the-mill regular expressions stop working correctly
        no Regexp::Grammars;
        $s = $sender =~ s/([a-z\d]+)[_\W\d]*/$1/r;
      }

      if ( ( $user ) = $dbc->resultset('User')->search({ nick => { like => '%'.$s.'%' }}) )
      {
        my $old_nick = $user->nick;
        $user->nick( $sender );
        $user->update;

        unless ( $dbc->resultset('Alias')->search({ user => $sender, nick => $old_nick }) )
        {
          $dbc->populate('Alias',
            [
              [ qw/user nick date/ ],
              [ $sender, $old_nick, $dt ],
            ]
          );
        }
      }
      else
      {
        # no idea who this guy is ...
        ( $user ) = $dbc->populate('User', [ [ 'nick' ], [ $sender ] ] );
      }
    }

    # someone is changing his/her nick. we care for this
    if ($type eq 'aka')
    {
      my $target = lc $/{$type}{target};
      if ( ( $alias ) = $dbc->resultset('Alias')->search({ user => $target, nick => $sender }, { order_by => { -desc => 'date' } }) )
      {
        $alias->date( $dt );
        $alias->update;
      }
      elsif ( ( $alias ) = $dbc->resultset('Alias')->search({ user => $sender, nick => $target }, { order_by => { -desc => 'date' } }) )
      {
        $alias->date( $dt );
        $alias->nick( $sender );
        $alias->user( $target );
        $alias->update;
      }
      else
      {
        $dbc->populate('Alias',
          [
            [ qw/user nick date/ ],
            [ $target, $sender, $dt ],
          ]
        );
      }

      # avoid duplicates from people logged in from several locations
      if ( $dbc->resultset('User')->find({ nick => $target }) )
      {
        $user->delete;
      }
      else
      {
        $user->nick( $target );
        $user->update;
      }
    }

    my $source = (ref $/{$type}{source} eq 'HASH') ? $/{$type}{source} : {};

    $dbc->populate('Message',
      [ 
        [ qw/date type sender src_name src_host target content/ ],
        [
          $dt,
          $type,
          $sender,
          $source->{name},
          $source->{host},
          $/{$type}{target},
          $/{$type}{content},
        ]
      ]
    );
  }
  else { say "FAIL: $line" if $ENV{DEBUG} }
}

close $fh;
