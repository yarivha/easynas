package EasyNAS::Controller::Settings;
use lib '/easynas/lib/EasyNAS/Controller';
use Mojo::Base 'Mojolicious::Controller', -signatures;
use easynas;


my $msg;
my $result;
my $addon = get_addon_info("settings");

sub view ($self) {
  if (!($self->session('is_auth'))) {
        $self->redirect_to('login');
  }
  my %easynas = easynas_info();
  my @lang_list = get_lang_list();
  my $action=$self->param('action'); 
  $msg="";
  $result="";
  $self->stash(addon => $addon,
		easynas => \%easynas,
                menu =>\@html_output,
                TEXT =>\%TEXT,
                addons =>\%addons,
	        lang_list => \@lang_list);


##### menu ######

  $self->stash(result => $result);
  $self->stash(msg => $msg);
  $self->render(template => 'easynas/settings'); 

}

1;
