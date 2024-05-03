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
  

  $self->stash(template => 'easynas/volume', 
	       title => $TEXT{$addons{volume}->{description}},
               program => $addons{volume}->{program},
               username => $username,
	       easynas => \%easynas,
               menu =>\@html_output,
               TEXT =>\%TEXT,
               addons =>\%addons,
               lang_list => \@lang_list,
	      );

 if (defined $action && $action eq "createvolmenu") 
 {
   my %users=users_info();
   my %groups=groups_info();
   my %fs=fs_info();
   $self->stash(users => \%users,
	        groups => \%groups,
		filesystems => \%fs);
   $self->render(template => 'easynas/volume_create');
   return;
 }


	      
##### menu #######
  my %volumes=vol_info();
  $self->stash(volumes =>\%volumes);
  $self->stash(result => $result);
  $self->stash(msg => $msg);	
  $self->render(template => 'easynas/volume');
}

1;
