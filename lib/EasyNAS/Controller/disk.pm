package EasyNAS::Controller::Disk;
use lib '.';
use Mojo::Base 'Mojolicious::Controller', -signatures;
use easynas;


sub view ($self) {
  if (!($self->session('is_auth'))) {
        $self->redirect_to('login');
  }
  my $username=$self->session('user');
  my $action=$self->param('action'); 
  $self->render(template => 'easynas/disk', 
	        title => $TEXT{'disk'},
		username => $username,
		menu =>\@html_output,
		TEXT =>\%TEXT
		);
}

1;
