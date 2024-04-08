package EasyNAS::Controller::Lxc;
use lib '.';
use Mojo::Base 'Mojolicious::Controller', -signatures;
use modules;


my $msg;
my $result;


sub view ($self) {
  $msg="";
  $result="";
  $self->render(template => 'easynas/lxc', 
	        title => $TEXT{%addons{lxc}->{description}},
                program => $addons{lxc}->{program},
                username => get_username(),
                menu =>\@html_output,
                TEXT =>\%TEXT,
                addons =>\%addons,
                lang_list => \@lang_list,
                result => $result,
                msg => $msg
		);
}

1;
