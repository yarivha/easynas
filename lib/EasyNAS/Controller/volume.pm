package EasyNAS::Controller::Volume;
use lib '.';
use Mojo::Base 'Mojolicious::Controller', -signatures;
use easynas;


my $msg;
my $result;


sub view ($self) {
  $msg="";
  $result="";
  $self->render(template => 'easynas/volume', 
	        title => $TEXT{%addons{filesystem}->{description}},
                program => $addons{filesystem}->{program},
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
