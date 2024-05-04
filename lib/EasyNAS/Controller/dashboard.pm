package EasyNAS::Controller::Dashboard;
use lib '/easynas/lib/EasyNAS/Controller';
use Mojo::Base 'Mojolicious::Controller', -signatures;
use XML::LibXML;
use easynas;


sub view ($self) {
  if (!($self->session('is_auth'))) {
        $self->redirect_to('login');
  }
  my $username=$self->session('user');
  my $action=$self->param('action'); 
  my @lang_list = get_lang_list();
  my %easynas = easynas_info();
  my %fs = fs_info();
  my %disks  = disk_info();
  my %vol    = vol_info();
  my %users  = users_info();
  my $updates="/etc/easynas/easynas.updates";
  my $missing_update;
  my $dom;

  if ($username eq "admin") {
   if (-e $updates) {
    eval {  $dom = XML::LibXML->load_xml(location => $updates) };
    if (! $@) {
     if ($dom->findnodes('/stream/update-status/update-list/update')) {
	$missing_update=1;
     }
     else {
	$missing_update=0;
     }	
    }
   }
  }

  $self->render(template => 'easynas/dashboard', 
		title => $TEXT{'dashboard'},
		program => $addons{dashboard}->{program},
		lang_list => \@lang_list,
		easynas =>\%easynas,
		menu =>\@html_output,
		TEXT =>\%TEXT,
		missing_update => $missing_update,
		addons =>\%addons,
		lang_list => \@lang_list,
		filesystems => \%fs,
		disks => \%disks,
		fs_number => scalar(keys %fs ),
		disk_number => scalar(keys %disks),
		vol_number => scalar(keys %vol),
		user_number => scalar(keys %users));
}

1;
