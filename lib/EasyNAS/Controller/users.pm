package EasyNAS::Controller::Users;
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
  $self->render(template => 'easynas/users', 
	        title => $TEXT{$addons{users}->{description}},
                program => $addons{users}->{program},
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
