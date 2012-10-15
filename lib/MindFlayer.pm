package MindFlayer;

use Mojo::Base 'Mojolicious';
use Mojolicious::Plugin::Config;

sub startup
{
  my $self = shift;

  $self->secret('cthulhufhtagn');

  # helpers

  my $logger = Mojo::Log->new;
  $self->helper( logger => sub { return $logger } );

  # routes

  my $r = $self->routes;
  $r->route('/')->to( text => "Soon ..." );
  
}

1;
