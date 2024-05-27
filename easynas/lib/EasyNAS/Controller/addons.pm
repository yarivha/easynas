package EasyNAS::Controller::Addons;
use lib '.';
use Mojo::Base 'Mojolicious::Controller', -signatures;
use XML::LibXML;
use easynas;


my $msg;
my $result;
my $addon = get_addon_info("addons");
my %TEXT=get_lang_text($addon->{'name'});


sub view ($self) {
  if (!($self->session('is_auth'))) {
        $self->redirect_to('login');
  }
  my $action=$self->param('action'); 
  $msg="";
  $result="";
  $self->stash( addon => $addon,
                TEXT =>\%TEXT);

 ##### menu #####
  
 my $addons_file = get_addons_file();
 my $addon_entry;
 my $package;
 my $dom;
 my $lang=0;
 my $srv=0;
 my $app=0;
 my $fs=0;
 my $stg=0;
 my $mm=0; 
 if (-e $addons_file) {
 open my $fh, '<', $addons_file;
 binmode $fh; # drop all PerlIO layers possibly created by a use open pragma
 $dom = XML::LibXML->load_xml(IO => $fh);
 foreach $addon_entry ($dom->findnodes('/stream/search-result/solvable-list/solvable')) {
  $package=$addon_entry->findvalue('./@name');
  $package =~ s/^\s+//;
  if ($package =~ /easynas-lang/) 
  {
   $lang++;
  }
  if ($package =~ /easynas-srv/)
  {
   $srv++;
  }
  if ($package =~ /easynas-app/)
  {
   $app++;
  }
  if ($package =~ /easynas-stg/)
  {
   $stg++;
  }
  if ($package =~ /easynas-fs/)
  {
   $fs++;
  }
  if ($package =~ /easynas-mm/)
  {
   $mm++;
  }
 }
} 
  $self->stash(result => $result,
               msg => $msg,
               fs => $fs,
               mm => $mm,
               srv => $srv,
               lang => $lang,
               stg => $stg,
	       app => $app );
  $self->render(template => 'easynas/addons');
}


1;
