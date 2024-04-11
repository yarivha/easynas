package EasyNAS::Controller::Dashboard;
use lib '.';
use Mojo::Base 'Mojolicious::Controller', -signatures;
use easynas;


sub view ($self) {
  if (!($self->session('is_auth'))) {
        $self->redirect_to('login');
  }
  my $username=$self->session('user');
  my $action=$self->param('action'); 
  my %fs = fs_info();
  my %disks  = drive_status();
  my %vol    = vol_info();
  my %users  = users_info();

  $self->render(template => 'easynas/dashboard', 
		title => $TEXT{'dashboard'},
		program => $addons{dashboard}->{program},
		username => get_username(),
		menu =>\@html_output,
		TEXT =>\%TEXT,
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
