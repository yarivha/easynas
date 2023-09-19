package EasyNAS;
use lib '.';
use Mojo::Base 'Mojolicious', -signatures;
use modules;

# This method will run once at server start
sub startup ($self) {

  # Load configuration from config file
  my $config = $self->plugin('NotYAMLConfig');

  # Configure the application
  $self->secrets($config->{secrets});


  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('dashboard#view');
  foreach my $item (keys %addons) {
	  $r->get('/'.$addons{$item}{'program'})->to($addons{$item}{'program'}.'#view');
  }
}

1;
