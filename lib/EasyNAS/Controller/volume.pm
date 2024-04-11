package EasyNAS::Controller::Volume;
use lib '.';
use Mojo::Base 'Mojolicious::Controller', -signatures;
use easynas;


my $msg;
my $result;


sub view ($self) {
  if (!($self->session('is_auth'))) {
        $self->redirect_to('login');
  }
  my $username=$self->session('user');
  my $action=$self->param('action'); 
  $msg="";
  $result="";
  $self->render(template => 'easynas/volume', 
	        title => $TEXT{%addons{filesystem}->{description}},
                program => $addons{filesystem}->{program},
                username => $username,
                menu =>\@html_output,
                TEXT =>\%TEXT,
                addons =>\%addons,
                lang_list => \@lang_list,
                result => $result,
                msg => $msg
		);
}

1;
