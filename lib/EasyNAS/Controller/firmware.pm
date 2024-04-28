package EasyNAS::Controller::Firmware;
use lib '/easynas/lib/EasyNAS/Controller';
use Mojo::Base 'Mojolicious::Controller', -signatures;
use XML::LibXML;
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
  $self->stash(title => $TEXT{$addons{firmware}->{description}},
                program => $addons{firmware}->{program},
                username => $username,
		easynas => \%easynas,
                menu =>\@html_output,
                TEXT =>\%TEXT,
                addons =>\%addons,
                lang_list => \@lang_list);

#### Update #####
 if (defined $action && $action eq "update") {
  update($self);
 }  

#### Refresh #####
 if (defined $action && $action eq "refresh") {
  refresh($self);
 }


##### Menu ######
  my $dom="";
  my $updates="/etc/easynas/easynas.updates";
  my %updates;
  my $update;
  my $package;
  my $desc;
  my $new_ver;
  my $old_ver;
  if (-e $updates) {
   $dom = XML::LibXML->load_xml(location => $updates);
   foreach $update ($dom->findnodes('/stream/update-status/update-list/update')) {
    $package=$update->findvalue('./@name');
    $desc=$update->findvalue('./summary');
    $new_ver=$update->findvalue('./@edition');
    $old_ver=$update->findvalue('./@edition-old');
    $updates{$package}=[$package,$desc,$new_ver,$old_ver];
   }
  }
  else {
   $result="fail";
   $msg=$TEXT{'firmware_noupdate'};
  }
 
  $self->stash(result => $result,
               msg => $msg,
	       updates => \%updates);	
  $self->render(template => 'easynas/firmware'); 
}

##### update #####
sub update($self) {
 my $package=$self->param('package');
 my $rc = system("/usr/bin/sudo /usr/bin/zypper -n update $package > /dev/null");
 if ($rc) {
  $result="fail";
  $msg=$TEXT{'firmware_update_failed'};
 }
 else {
  $result="success";
  $msg=$TEXT{'firmware_update_success'};
 }
 $rc=system("/usr/bin/sudo /usr/bin/zypper --quiet -x lu -a --repo EasyNAS  | /usr/bin/sudo /usr/bin/tee /etc/easynas/easynas.updates");
 return;
}

#####  Refresh #####
sub refresh($self) {
 my $rc;
 $rc=system("/usr/bin/sudo /usr/bin/zypper --quiet -x lu -a --repo EasyNAS  | /usr/bin/sudo /usr/bin/tee /etc/easynas/easynas.updates");
 if ($rc) {
  $result="fail";
  $msg=$TEXT{'firmware_not_refreshed'};
 }
 else {
  $result="success";
  $msg=$TEXT{'firmware_refreshed'};
 }
  return;
} 



1;
