package EasyNAS::Controller::Groups;
use lib '.';
use Mojo::Base 'Mojolicious::Controller', -signatures;
use easynas;


my $msg;
my $result;


sub view ($self) {
  if (!($self->session('is_auth'))) {
        $self->redirect_to('login');
  }
  my %easynas = easynas_info();
  my @lang_list = get_lang_list();
  my $action=$self->param('action'); 
  $msg="";
  $result="";
  $self->stash( title => $TEXT{$addons{groups}->{description}},
                program => $addons{groups}->{program},
		easynas =>\ %easynas,
                menu =>\@html_output,
                TEXT =>\%TEXT,
                addons =>\%addons,
                lang_list => \@lang_list
		);

 ##### creategroup #####
 if (defined $action && $action eq "creategroup") {
  creategroup($self);
 }

 ##### deletegroup #####
 if (defined $action && $action eq "deletegroup") {
  deletegroup($self);
 }


 ##### creategroupmenu #####
  if (defined $action && $action eq "creategroupmenu") {
   $self->render(template => 'easynas/groups_create');
   return;
  }
 

 ##### menu #####
 
  my %groups=groups_info();
  $self->stash(groups =>\%groups);
  $self->stash(result => $result);
  $self->stash(msg => $msg);
  $self->render(template => 'easynas/groups');
}


##### creategroup #####
sub creategroup($self) {
 my $group=$self->param("group");
 my $rc;
 $rc=system("/usr/bin/sudo","/usr/sbin/groupadd", $group);
 if ($rc)
  {
   $result="fail";
   $msg=$TEXT{'groups_failed_to_add'};
  }
  else 
  {
   $result="success";
   $msg=$TEXT{'groups_added'};
  }
  return;
}


sub deletegroup($self) { 
 my $group=$self->param("group");
 my $rc;
 $rc=system("/usr/bin/sudo","/usr/sbin/groupdel", $group);
 if ($rc)
  {
   $result="fail";
   $msg=$TEXT{'groups_failed_to_delete'};
  }
  else
  {
   $result="success";
   $msg=$TEXT{'groups_deleted'};
  }
  return;
}


1;
