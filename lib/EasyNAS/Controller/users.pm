package EasyNAS::Controller::Users;
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
  $self->stash(title => $TEXT{$addons{users}->{description}},
                program => $addons{users}->{program},
                username => $username,
                menu =>\@html_output,
                TEXT =>\%TEXT,
                addons =>\%addons,
                lang_list => \@lang_list);

  ##### createuser #####
  if ($action eq "createuser") {
   createuser($self);
  }

  ##### createusermenu #####
  if ($action eq "createusermenu") {
   my %groups=groups_info();
   $self->stash(groups => \%groups);
   $self->render(template => 'easynas/users_create');
   return;
  }

  ##### menu ######

  my %users=users_info();
  $self->stash(users =>\%users);
  $self->stash(result => $result);
  $self->stash(msg => $msg);
  $self->render(template => 'easynas/users'); 

}


##### createuser ######
sub createuser($self) {
 my $name=$self->param("name");
 my $desc=$self->param("desc");
 my $password1=$self->param("password1");
 my $password2=$self->param("password2");
 my @groups=$self->param("groups");
 my $mount_dir=get_mount_dir;
 my $group_default=get_group_default;
 my $groups;
 my $rc;

 foreach(@groups)
    {
	$groups=$groups.$_.",";
    }
    chop($groups);

 if (!$name)
    {
     $result="fail";
     $msg=$TEXT{'users_user_must_exist'};
     return;
    }
 if (!$password1)
    {
     $result="fail";
     $msg=$TEXT{'users_password_must_exist'};
     return;
    }
 if ($password1 ne $password2) 
    {
     $result="fail";
     $msg=$TEXT{'users_passwords_do_no_match'};
     return;
    }


 $rc = system("/usr/bin/sudo /usr/sbin/useradd -g $group_default -G \"$groups\" -d $mount_dir -c \"$desc\" $name");
    if ($rc ne 0)
    {
      $result="fail";
      $msg=$TEXT{'users_failed_to_add_user'};
      return;
    } 
 $rc = system("/usr/bin/echo $name:$password1 | /usr/bin/sudo /usr/sbin/chpasswd");
    if ($rc ne 0)
    {
	$result="fail";
        $msg=$TEXT{'users_failed_to_change_password'};
	return;
    }
  
 if( -f "/usr/bin/smbpasswd" )
    {
      $rc = system("/usr/bin/echo -e \"$password1\n$password1\" | /usr/bin/sudo /usr/bin/smbpasswd -s -a $name >/dev/null");
      if ($rc ne 0)
	 {
	  $result="fail";
          $msg=$TEXT{'users_failed_to_add_samba_user'};
	  return;
	 }
    } 
 
  
    $result="success";
    $msg=$TEXT{'users_created'};
    return; 
}

1;
