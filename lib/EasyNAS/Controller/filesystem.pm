package EasyNAS::Controller::Filesystem;
use lib '/easynas/lib/EasyNAS/Controller';
#use Switch;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use easynas;

my $mount_dir=get_mount_dir();
my $conf_cron=get_conf_cron();
my $msg;
my $result;

sub view($self) {
    if (!($self->session('is_auth'))) {
        $self->redirect_to('login');
    }
    my $username=$self->session('user');
    my $action=$self->param('action'); 
    $msg="";
    $result="";
    $self->stash(title => $TEXT{%addons{filesystem}->{description}},
                program => $addons{filesystem}->{program},
                username => $username,
                menu =>\@html_output,
                TEXT =>\%TEXT,
                addons =>\%addons,
                lang_list => \@lang_list);

#--------- Create Menu ----------
    if ($action eq "createfsmenu") {
      my %disks = disk_info();
      my $size;
      my $pre_size;
      my $number_free = 0;  
      my @free_disks; 
      my %raid;

      foreach (sort(keys(%disks)))
      {
        if ($disks{$_}[0] eq "Free")
        {
            $size=$disks{$_}[1];
            $pre_size=$disks{$_}[2];
            push(@free_disks,$_." ".$size.$pre_size);
            $number_free++;
        }
      }
      if ($number_free eq 0)
      {
	$result="fail";     
	$msg=$TEXT{'no_free_disk'};
      }
      else {
	$raid{'single'}='JBOD';
        if ($number_free > 1)
        {
          $raid{'raid0'}='RAID0';
          $raid{'raid1'}='RAID1';;
        }
        if ($number_free > 2)
        {
          $raid{'raid5'}='RAID5';
        }
        if ($number_free > 3)
        {
          $raid{'raid6'}='RAID6';
          $raid{'raid10'}='RAID10';
        }
	$result="success";
      }
       $self->stash(freedisks => \@free_disks);
       $self->render(template => 'easynas/filesystem_create');
       return;
    }

#--------- settingsmenu ---------
    if ($action eq "settingsmenu") {
      my $fs=$self->param("fs");
      #  my $uuid=$self->param("uuid");
      #my $raid = raid_status($fs);
      #my @disks = `/usr/bin/sudo /sbin/btrfs filesystem show $uuid | /usr/bin/grep devid`;
      #my %disks = drive_status();
      my $pre_disk = 0;
      my $number_disks = 0;
      my $number;
      my $disk;
      my $size;
      my $used;
      my $status;
      my $compress;
       
      $self->stash( fs_name => $fs);
      $self->render(template => 'easynas/filesystem_settings');
      return;
    }  


#--------- createfs ----------
    if ($action eq "createfs") {
      &createfs($self);
    }


#-------- Unmount ---------
    if ($action eq "unmoun") { 
	&unmount($self);
    }


#------- Mount -------
   if ($action eq "mount") {
        &mount($self);
    }

#-------ChangeName -------
   if ($action eq "changename")  {
     &changename($self);
   }

#------- Menu --------    
   my %fs=fs_info();
   $self->stash(filesystems =>\%fs);
   $self->stash(result => $result);
   $self->stash(msg => $msg);
   $self->render(template => 'easynas/filesystem');
}



#--------- deletefs ---------
sub deletefs($self) {

    my $fs         = $self->param("fs");
    my $uuid       = $self->param("uuid");
    my $auto_mount = `/usr/bin/sudo /usr/bin/grep $uuid /etc/fstab`;
    my @disks      = `/usr/bin/sudo /sbin/btrfs filesystem show $uuid | /usr/bin/grep devid`;
    my @volumes    = `/usr/bin/sudo /sbin/btrfs subvolume list $mount_dir/$fs`;
    my $disk;
    my $id;
    my $vol;
    my $rc;

    if (@volumes)
    {
	$result="fail";
	$msg=$TEXT{'filesystem_contain_vol'};	
	return;
    }
    if ($auto_mount)
    {
	`/usr/bin/sudo /usr/bin/sed -i '$mount_dir.$fs /d' /etc/fstab`;
	$rc = system("/usr/bin/sudo /usr/bin/umount -l $mount_dir/$fs > /dev/null ");
	if ($rc ne 0)
	{
	    $result="fail";
	    $msg=$TEXT{'fs_failed_unmounting_fs'};
	    return;
	}
    }
    foreach (@disks)
    {
	(undef,undef,undef,undef,undef,undef,undef,$disk) = split(" ",$_);
	$rc = system("/usr/bin/sudo /usr/sbin/wipefs -f -o 0x10040 $disk >/dev/null");
	if ($rc ne 0)
	{
           $result="fail";
	   $msg=$TEXT{'error_formating_disk'};
	   return;

	}
    }
    `/usr/bin/sudo /usr/bin/rm -fr $mount_dir/$fs`;
    `/usr/bin/sudo /usr/bin/sed -i '$mount_dir.$fs /d' $conf_cron`;
     $result="success";
     $msg=$TEXT{'fs_deleted'};
     return;
}



sub createfs($self) {

    my @disks      = $self->param("disks");
    my $fs         = $self->param("name");
    my $raid       = $self->param("raid");
    my $options    = $self->param("options");
    my $mount      = $self->param("mount");
    my $ssd        = $self->param("ssd");
    my $defrag     = $self->param("defrag");
    my $compress   = $self->param("compress"); 
    my $device     = "";
    my $raid_disks = "";
    my $number     = 0;
    my $uuid;
    my $btrfs;
    my $disk;
    my $rc;

if ($ssd)
    {
	$ssd = "ssd,discard,noatime";
    }
    else
    {
	$ssd = "";
    }
    if ($defrag)
    {
	$defrag = "autodefrag";
    }
    else
    {
	$defrag = "";
    }
    foreach (@disks)
    {
	($disk,undef) = split(" ", $_);
	$raid_disks   = $raid_disks." ".$disk;
	$device       = $device."device=".$disk.",";
	$number++;
    }

    if ($number eq 0)
    {

	$result="fail";
        $msg=$TEXT{'no_disks_were_selected'};
	return;
    }
    if ($fs eq '')
    {
	$result="fail";    
	$msg=$TEXT{'no_fs_name_was_entered'};
	return;
}
    if ($fs eq "ROOT" || $fs eq "BOOT")
    {
	$result="fail";    
        $msg=$TEXT{'reserved_fs'};
	return;
    }

    if (($raid eq "raid0") && ($number<2))
    {
	$result="fail";    
        $msg=$TEXT{'raid_0_require_two'};
	return;
    }
    if (($raid eq "raid1") && ($number<2))
    {
	$result="fail";    
        $msg=$TEXT{'raid_1_require_two'};
	return;
    }
    if (($raid eq "raid10") && ($number<4))
    {
	$result="fail";    
        $msg=$TEXT{'raid_10_require_four'};
	return;
    }
    if (($raid eq "raid5") && ($number<3))
    {
	$result="fail";    
        $msg=$TEXT{'raid_5_require_three'};
	return;
    }
    if (($raid eq "raid6") && ($number<4))
    {
	$result="fail";    
        $msg=$TEXT{'raid_6_require_four'};
	return;
    }

    if ( !-d "$mount_dir/$fs") { 
      $rc = system("/usr/bin/sudo /bin/mkdir $mount_dir/$fs");
      if ($rc ne 0)
      {
	$result="fail";    
        $msg=$TEXT{'failed_creating_directory'};
	return;
      }
    }
     
    $rc = system("/usr/bin/sudo /sbin/mkfs.btrfs -f -L $fs -d $raid -m $raid $raid_disks > /dev/null");
    if ($rc ne 0)
    {
	$result="fail";    
	$msg=$TEXT{'failed_creating_fs'};
	return;
    }

    $btrfs=`/usr/bin/sudo /usr/sbin/btrfs filesystem show $fs | /usr/bin/grep uuid`;
    (undef,undef,undef,$uuid)=split(" ",$btrfs);

    if ($mount)
    {
	`/bin/echo "UUID=$uuid $mount_dir/$fs btrfs $options,compress=$compress,$ssd,$defrag 0 0" | /usr/bin/sudo /usr/bin/tee -a /etc/fstab`;
	$rc = system("/usr/bin/sudo /usr/bin/mount -t btrfs -o $options,compress=$compress,$ssd,$defrag $mount_dir/$fs > /dev/null");
    }
    if ($rc ne 0)
    {
	$result="fail";    
        $msg=$TEXT{'failed_mounting_fs'};
	return;
    }

    $result="success";    
    $msg=$TEXT{'fs_created'};
    return;
}

sub unmount($self) {

    my $fs = $self->param("fs");
    my $rc;

    if ($fs eq "ROOT" || $fs eq "BOOT")
    {
      $result="fail";
      $msg=$TEXT{'fs_failed_unmounting_fs'};
      write_log("filesystem","ERROR",$TEXT{'fs_failed_unmounting_fs'});
      return;
    }
    $rc = system("/usr/bin/sudo /usr/bin/umount -l $mount_dir/$fs > /dev/null");
    if ($rc ne 0) {
      $result="fail";
      $msg=$TEXT{'fs_failed_unmounting_fs'};
      write_log("filesystem","ERROR",$TEXT{'fs_failed_unmounting_fs'});
      return;
    }
    $rc = system("/usr/bin/sudo /usr/bin/sed -i '$mount_dir.$fs /d' /etc/fstab > /dev/null");
    $result="success";
    $msg="Filesystem was unmouted";
    write_log("filesystem","INFO","Unmount $mount_dir/$fs");
}



sub mount($self) {



}


sub changename($self) {

  my $fs    = $self->param("fs");
  my $newfs = $self->param("newfs");
  my %fs=fs_info();
  my $mounted=$fs{$fs}[4];
  my $rc;

  if ($fs eq $newfs)
    {
     $result="fail";	
     $msg=$TEXT{'filesystem_not_changed'}.$mounted;
     write_log("filesystem","ERROR",$TEXT{'filesystem_not_changed'});
     return;
    }

    #    if (mounted($fs) eq "UnMounted")
    #{
    # $msg=$TEXT{'fs_need_to_be_unmounted'};
    # $result="fail";
    # write_log("filesystem","ERROR",$TEXT{'fs_need_to_be_unmounted'});
    # return;
    #}
    
    if ($fs eq "ROOT" || $fs eq "BOOT")
    {
     $msg=$TEXT{'filesystem_not_changed'};
     $result="fail";
     write_log("filesystem","ERROR",$TEXT{'filesystem_not_changed'});
     return;
    }

    $rc = system("/usr/bin/sudo /sbin/btrfs filesystem label $mount_dir/$fs $newfs >/dev/null");
    if ($rc ne 0)
    {
     $msg=$TEXT{'filesystem_not_changed'};
     $result="fail";
     write_log("filesystem","ERROR",$TEXT{'filesystem_not_changed'});
     return;
    }
    write_log("filesystem","INFO","FileSystem $fs changed name to $newfs");
    $rc = system("/usr/bin/sudo /usr/bin/umount -l $mount_dir/$fs > /dev/null");
    if ($rc ne 0)
    {
     $msg=$TEXT{'fs_failed_unmounting_fs'};
     $result="fail";
     write_log("filesystem","ERROR",$TEXT{'fs_failed_unmounting_fs'});
     return;
    }
    write_log("filesystem","INFO","Filesystem $fs was unmounted");
    `/usr/bin/sudo /usr/bin/mv $mount_dir/$fs $mount_dir/$newfs`;
    `/usr/bin/sudo /usr/bin/sed -i 's%$mount_dir/$fs%$mount_dir/$newfs%g' /etc/fstab`;
    $rc = system("/usr/bin/sudo /usr/bin/mount $mount_dir/$newfs > /dev/null");
    if ($rc ne 0)
    {
     $msg=$TEXT{'failed_mounting_fs'};
     $result="fail";
     write_log("filesystem","ERROR",$TEXT{'failed_mounting_fs'});
     return;
    }
    $msg=$TEXT{'fs_name_changed'};
    $result="success";
    write_log("filesystem","INFO","Filesystem $newfs was mounted");
    return;
}
1;

