package EasyNAS::Controller::Disk;
use lib '/easynas/lib/EasyNAS/Controller';
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
  $self->stash(title => $TEXT{%addons{disk}->{description}},
                program => $addons{disk}->{program},
                username => $username,
                menu =>\@html_output,
                TEXT =>\%TEXT,
                addons =>\%addons,
                lang_list => \@lang_list);


  ##### menu ######

  my %disks=disk_info();
  $self->stash(disks =>\%disks);
  $self->stash(result => $result);
  $self->stash(msg => $msg);
  $self->render(template => 'easynas/disk'); 
  print keys(%disks);
}

1;
