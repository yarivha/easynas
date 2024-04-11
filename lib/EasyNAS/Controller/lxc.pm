package EasyNAS::Controller::Lxc;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use lib '/easynas/lib/EasyNAS/Controller';
use easynas;

my $msg;
my $result;
my %systems;
my @systems;
my $name;
my $state;
my $ip;

###### Get Systems List #######
@systems=`/usr/bin/lxc-ls --fancy`;
foreach (@systems) {
 ($name,$state,undef,undef,$ip,undef)=split(" ",$_);
 if ($name ne "NAME") {
  $systems{$name}=[$name,$state,$ip];
 }
}

sub view ($self) {
  if (!($self->session('is_auth'))) {
        $self->redirect_to('login');
  }
  my $username=$self->session('user');
  my $action=$self->param('action'); 
  $msg="";
  $result="";
  
  if (defined $action && $action eq "terminal" )
  {
    system("sudo /usr/bin/ttyd -p 8080 -o -W bash &");
    $self->redirect_to('http://192.168.64.39:8080/'); 
    return;
  }  

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
