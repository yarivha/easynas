package EasyNAS::Controller::Volume;
use lib '/easynas/lib/EasyNAS/Controller';
use Mojo::Base 'Mojolicious::Controller', -signatures;
use easynas;


my $msg;
my $result;
my $mount_dir=get_mount_dir();
my $conf_cron=get_conf_cron();

sub view ($self) {
  if (!($self->session('is_auth'))) {
        $self->redirect_to('login');
  }
  my %easynas = easynas_info();
  my @lang_list = get_lang_list();
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


####### deletevol ######
 if (defined $action && $action eq "deletevol") 
 {
  deletevol($self);
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
 my $user_perm=$self->param("user_perm");
 my $group_perm=$self->param("group_perm");
 my $others_perm=$self->param("others_perm");
 my $rc;
 my $permission=0;
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
 if ($user_perm eq "read")
 {
  $permission = $permission+500;
 }
 if ($user_perm eq "read&write")
 {
  $permission = $permission+700;
 }
 if ($group_perm eq "read")
 {
  $permission = $permission+50;
 }
 if ($group_perm eq "read&write")
 {
  $permission = $permission+70;
 }
 if ($others_perm eq "read")
 {
  $permission = $permission+5;
 }
 if ($others_perm eq "read&write")
 {
  $permission = $permission+7;
 } 

 $rc = system("/usr/bin/sudo /sbin/btrfs subvolume create $mount_dir/$fs/$vol > /dev/null");
 if($rc ne 0)
 {
   $result="fail";
   $msg=$TEXT{'vol_created'};
 }
 else 
 {
   $rc = system("/usr/bin/sudo /usr/bin/chown $user.$group $mount_dir/$fs/$vol > /dev/null");
   $rc = system("/usr/bin/sudo /bin/chmod $permission $mount_dir/$fs/$vol > /dev/null");  
   $result="success";
   $msg=$TEXT{'vol_created'};

 }
 return;
}


##### deletevol #####
sub deletevol($self) {
 my $vol=$self->param("vol");
 my $cmount_dir;
 $cmount_dir = substr($mount_dir,1);
 my $rc = system("/usr/bin/sudo /sbin/btrfs subvolume delete $mount_dir/$vol > /dev/null");
 if ($rc ne 0)
 {
  $result="fail";
  $msg=$TEXT{'vol_faild_to_delete'};
 }
 else 
 {
  if (`/usr/bin/grep " $mount_dir/$vol " $conf_cron`)
  {   
    system("/usr/bin/sudo /usr/bin/sed -i '/.$cmount_dir.$vol /d' $conf_cron");
    system("/usr/bin/sudo /usr/bin/systemctl restart cron.service restart");
  }
  $result="success";
  $msg=$TEXT{'vol_deleted'};
 }
 return;
}

1;
