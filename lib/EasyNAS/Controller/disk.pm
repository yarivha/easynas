package EasyNAS::Controller::Disk;
use lib '.';
use Mojo::Base 'Mojolicious::Controller', -signatures;
use modules;


sub view ($self) {

  $self->render(template => 'easynas/disk', 
	        title => $TEXT{'disk'},
		username => get_username(),
		menu =>\@html_output,
		TEXT =>\%TEXT
		);
}

1;
