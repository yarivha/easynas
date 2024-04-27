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
  my %easynas = easynas_info();
  my $action=$self->param('action'); 
  $msg="";
  $result=""; 
  $self->stash(title => $TEXT{$addons{disk}->{description}},
                program => $addons{disk}->{program},
                username => $username,
		easynas => \%easynas,
		menu =>\@html_output,
		TEXT =>\%TEXT,
		addons =>\%addons,
		lang_list => \@lang_list);

  ##### format #####
  if (defined $action && $action eq "format") {
   disk_format($self);
  }

  ##### menu ######

  my %disks=disk_info();
  $self->stash(disks =>\%disks);
  $self->stash(result => $result);
  $self->stash(msg => $msg);
  $self->render(template => 'easynas/disk'); 
}

###### format #######
sub disk_format($self) {

 my $disk = $self->param("disk");
 my $rc = system("/usr/bin/sudo /usr/sbin/wipefs -f -o 0x10040  $disk >/dev/null");
 
 if ($rc) {
  $result="success";
  $msg=$TEXT{'disk_format_success'};
 }
 else {
  $result="fail";
  $msg=$TEXT{'disk_format_failed'};
 }
 return;
}

1;
