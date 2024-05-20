package EasyNAS::Controller::Network;
use lib '/easynas/lib/EasyNAS/Controller';
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
  $self->stash(title => $TEXT{$addons{network}->{description}},
                program => $addons{network}->{program},
		easynas => \%easynas,
		menu =>\@html_output,
		TEXT =>\%TEXT,
		addons =>\%addons,
		lang_list => \@lang_list);
#### save #####
if (defined $action && $action eq "save") {
  save($self);
}

   ##### edit #####
  if (defined $action && $action eq "edit") {
   my $interface=$self->param("interface");
   my %networks=networks_info();
   $self->stash(networks => \%networks,
	        interface => $interface);
   $self->render(template => 'easynas/network_edit');
   return;
  }

  ##### menu ######

  my %networks=networks_info();
  $self->stash(networks => \%networks,
	       result => $result,
      	       msg => $msg );
  $self->render(template => 'easynas/network'); 
}

##### save ######
sub save($self) {
  my $interface=$self->param("interface");
  my $network=$self->param("network");
  my $ip=$self->param("ip");
  my $subnet=$self->param("subnet");
  my $gateway=$self->param("gateway");
  my $dns1=$self->param("dns1");
  my $dns2=$self->param("dns2");
  my $domain=$self->param("domain");
  my $rc;

  if ($network eq "auto") {
   $rc=system("/usr/bin/sudo /usr/bin/nmcli con mod $interface ipv4.method auto");
   $rc=system("/usr/bin/sudo /usr/bin/nmcli con mod $interface ipv4.gateway \"\" ");
   $rc=system("/usr/bin/sudo /usr/bin/nmcli con mod $interface ipv4.address \"\" ");
   $rc=system("/usr/bin/sudo /usr/bin/nmcli con mod $interface ipv4.dns \"\" ");
   $rc=system("/usr/bin/sudo /usr/bin/nmcli con up $interface");
   if ($rc) {
    $result="failed";
    $msg=$TEXT{'network_failed_to_save'};
   }
   else {
    $result="success";
    $msg=$TEXT{'network_saved'};
   }
  }
  else {
   $rc=system("/usr/bin/sudo /usr/bin/nmcli con mod $interface ipv4.method manual");
   $rc=system("/usr/bin/sudo /usr/bin/nmcli con mod $interface ipv4.addresses $ip/$subnet");
   $rc=system("/usr/bin/sudo /usr/bin/nmcli con mod $interface ipv4.gateway $gateway");
   $rc=system("/usr/bin/sudo /usr/bin/nmcli con mod $interface ipv4.dns $dns1 $dns2");
   $rc=system("/usr/bin/sudo /usr/bin/nmcli con up $interface");
   if ($rc) {
    $result="failed";
    $msg=$TEXT{'network_failed_to_save'};
   }
   else {
    $result="success";
    $msg=$TEXT{'network_saved'};
   }
  }
  return;
}

1;
