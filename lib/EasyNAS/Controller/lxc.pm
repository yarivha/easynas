package EasyNAS::Controller::Lxc;
use lib '.'; 
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Common;


my $msg;
my $result;
my %systems;


sub view ($self) {
  $msg="";
  $result="";
  $systems{test1} = ["test1","Stopped","192.168.1.40"];
  $self->render(template => 'easynas/lxc', 
	        title => $TEXT{%addons{lxc}->{description}},
                program => $addons{lxc}->{program},
                username => get_username(),
                menu =>\@html_output,
                TEXT =>\%TEXT,
                addons =>\%addons,
                lang_list => \@lang_list,
		systems => \%systems,
                result => $result,
                msg => $msg
		);
}

1;
