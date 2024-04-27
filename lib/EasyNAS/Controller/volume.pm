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
  my %easynas = easynas_info();
  my $action=$self->param('action'); 
  $msg="";
  $result="";
  $self->render(template => 'easynas/volume', 
	        title => $TEXT{$addons{volume}->{description}},
                program => $addons{volume}->{program},
                username => $username,
		easynas => \%easynas,
                menu =>\@html_output,
                TEXT =>\%TEXT,
                addons =>\%addons,
                lang_list => \@lang_list,
                result => $result,
                msg => $msg
		);
}

1;
