package EasyNAS::Controller::Volume;
use lib '.';
use Mojo::Base 'Mojolicious::Controller', -signatures;
use easynas;


my $msg;
my $result;
my $mount_dir=get_mount_dir();

sub view ($self) {
  if (!($self->session('is_auth'))) {
        $self->redirect_to('login');
  }
  my %easynas = easynas_info();
  my $action=$self->param('action'); 
  $msg="";
  $result="";
  

  $self->stash(template => 'easynas/volume', 
	       title => $TEXT{$addons{volume}->{description}},
               program => $addons{volume}->{program},
	       easynas => \%easynas,
               menu =>\@html_output,
               TEXT =>\%TEXT,
               addons =>\%addons,
               lang_list => \@lang_list,
	      );

##### createvol #######	     
 if (defined $action && $action eq "createvol")
 {
   createvol($self);
 }


 ###### createvolmenu #######
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

########### createvol ###############
sub createvol($self) {
 my $vol=$self->param("name");
 my $fs=$self->param("fs");
 my $user=$self->param("user");
 my $group=$self->param("group");
 my $rc;

 if ($vol eq '')
 { 
   $result="fail";
   $msg=$TEXT{'vol_no_vol_name'};
   return;
 }


 if ($fs eq '') 
 {
  $result="fail";
  $msg=$TEXT{'vol_no_fs_selected'};
  return;
 }


 $rc = system("/usr/bin/sudo /sbin/btrfs subvolume create $mount_dir/$fs/$vol > /dev/null");
 if($rc ne 0)
 {
   $result="fail";
   $msg=$TEXT{'vol_created'};
 }
 else 
 {
   $result="success";
   $msg=$TEXT{'vol_created'};
 }
 return;
}


1;
