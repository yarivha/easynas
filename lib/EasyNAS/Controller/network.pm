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


1;
