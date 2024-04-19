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
  my $action=$self->param('action'); 
  $msg="";
  $result="";
  $self->stash(title => $TEXT{$addons{firmware}->{description}},
                program => $addons{firmware}->{program},
                username => $username,
                menu =>\@html_output,
                TEXT =>\%TEXT,
                addons =>\%addons,
                lang_list => \@lang_list);




##### Menu ######
  my $dom="";
  my $updates=get_updates();
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
   $msg=$TEXT{'firmware_latest'};
  }
  $self->stash(result => $result,
               msg => $msg,
	       updates => \%updates);	
  $self->render(template => 'easynas/firmware'); 
}

1;
