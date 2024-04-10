#! /usr/bin/perl -w 
#
# easynas.pm
# 
# EasyNAS is free software: You can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# This file is part of EasyNAS (c) created by Yariv Hakim 2012-2017
#
# Homepage    : https://www.easynas.org
# Sourceforge : https://sourceforge.net/projects/easynas/
#
#########################################################################

package Common;

use strict;
use warnings;
use File::Path qw( make_path );
use Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw();
our @EXPORT    = qw( %TEXT %addons @html_output @lang_list get_mount_dir get_conf_cron get_username get_categories  
		     write_log fs_info vol_info users_info drive_status);

############# Declarations #####################
my $authentication_enable = 1;
my $demo_site   = "demo.easynas.org";
my $lang_default="en-en";
my $group_default = "users";
my %compress = ( 'no'=>'None','lzo'=>'Faster','zlib'=>'Better');
my %mount_options = ( 'rw'=>'Read&Write','ro'=>'ReadOnly');


############# Configuration dirs ###############
my $addons_dir = "/easynas/addons";
my $lang_dir= "/easynas/lang";
my $conf_dir= "/etc/easynas";
my $mount_dir = "/mnt";

##########  Configuration files ############
my $lang_conf=$conf_dir."/easynas.lang";
my $conf_cron="/etc/cron.d/easynas.cron";
my $conf_roles=$conf_dir."/easynas.roles";
my $conf_cert  = $conf_dir."/easynas.pem";
my $conf_hosts = "/etc/hosts";
my $log_file = "/var/log/easynas/easynas.log";

############ Settings ################
our %addons;
our @html_output;
our @categories;
our %TEXT;
our @lang_list;

######### easynas_ver #########
sub easynas_ver
{
 my $imageversion=`/usr/bin/cat /etc/ImageVersion`;
 my $version;
 (undef,$version)=split("-",$imageversion);
 return($version);
}


######## easynas_hardware #######
sub easynas_hardware
{
 my $hardware=`/usr/bin/uname -m`;
 return($hardware);
}


############# get_mount_dir ####################
sub get_mount_dir
{
 return($mount_dir)
}


############# get_conf_cron ###############
sub get_conf_cron
{
 return($conf_cron)
}


######### get_lang #########
sub get_lang
{
    my $lang;
    if (-e $lang_conf )
    {
        $lang=`/usr/bin/cat $lang_conf`;
        chomp($lang);
        if (-e $lang_dir."/".$lang."/iso.txt")
        {
            return $lang;
        }
        else
        {
            return "en-en";
        }
    }
    else
    {
        `echo "en-en" | /usr/bin/sudo /usr/bin/tee $lang_conf`;
        return "en-en";
    }
}


########### write_log ###########
sub write_log
{
 my $addon=$_[0];
 my $type=$_[1];
 my $message=$_[2];
 my $timestamp=localtime();
 my $FH;
 unless(-e $log_file) {
    #Create the file if it doesn't exist
    `sudo touch $log_file`;
    `sudo chown easynas.easynas $log_file`;
 }
 open($FH, '>>', $log_file) or die $!;
 print $FH $timestamp." "."[$TEXT{$addons{$addon}->{description}}]"." ".$type." ".get_username()." ".$message."\n";
 close $FH;
}



####### mounted ########
sub mounted
{   
    my $fs = $_[0];
    my $result="Mounted";
    
    if ((`/usr/bin/sudo /bin/mount | /usr/bin/grep "$mount_dir/$fs"` eq "") && ($fs ne "ROOT"))
    {
        $result="UnMounted";
    }
    return $result;
}    


########### get_compress_status ##########
sub get_compress_status
{
 my $fs=$_[0];
 my $compress="none";
 if (`/usr/bin/sudo /usr/bin/mount | /usr/bin/grep "$mount_dir/$fs" | /usr/bin/grep "compress=zlib"`)
  {
   $compress="better";
  }
  elsif (`/usr/bin/sudo /usr/bin/mount | /usr/bin/grep "$mount_dir/$fs" | /usr/bin/grep "compress=lzo"`)
  {
   $compress="faster";
  }
  return($compress);
}


######## Raid Status ##########
    
sub raid_status
{   
    my $raid;
    my $null;
    my $result; 
    my $fs=$_[0];
    my @fs_df;
    if ($fs eq "ROOT") {
     @fs_df=`sudo /sbin/btrfs fi df / | grep "Data" `;
    }
    else { 
     @fs_df=`sudo /sbin/btrfs fi df $mount_dir/$fs | grep "Data" `;
    }
    foreach (@fs_df) {
        ($null,$raid,$null,$null)=split(/ /,$_);
    }
    chop($raid);
    if ($raid eq "single") {
        $result="JBOD";
    }
    else {
        $result=$raid;
    }
    return $result;
}



######## current_lang ########
sub current_lang
{
    my $lang;
    if (-e $lang_conf )
    {
        $lang=`/usr/bin/cat $lang_conf`;
        chomp($lang);
        if (-e $lang_dir."/".$lang."/iso.txt")
        {
            return $lang;
        }
        else
        {
            return "en-en";
        }
    }
    else
    {
        `echo "en-en" | /usr/bin/sudo /usr/bin/tee $lang_conf`;
        return "en-en";
    }
}
 
 
########### lang_list #############
sub get_lang_list
{
 my $file;
 my $lang;
 my $flag;
 
 if (!@lang_list) {
  opendir (DIR, $lang_dir) or die "Error";
  while ($file = readdir(DIR))
  {
   if ($file ne "." && $file ne ".." && -f "$lang_dir/$file/iso.txt")
        {
            ($lang,$flag) = split(",",`/usr/bin/cat $lang_dir/$file/iso.txt`);
            push(@lang_list,{name=>$lang,symbol=>$file,flag=>$flag});
        }
    }
  close(DIR);
 }
  return;
}


########## get_lang_text ###########
#syb get_lang_text
#{
#  my $addon=$_;
#  if (current_lang() ne $lang_default)
#    {
#     require "$lang_dir/$lang_default/$file";
#    }
#
#    ### load selected language string #####
#    opendir (DIR, $lang_dir."/".current_lang() ) or die "Error";
#    while ($file = readdir(DIR))
#    {
#        if ($file ne "iso.txt" && $file ne "." && $file ne ".." )
#        {
#            require "$lang_dir/".current_lang()."/$file";
#        }
#    }
#    close(DIR);
#}

 




########## load_language ###########

sub load_language
{

    my $file;

    ### load default language stings ###
    if (current_lang() ne $lang_default)
    {
	opendir (DIR, $lang_dir."/".$lang_default) or die "Error";
	while ($file = readdir(DIR))
	{
	    if ($file ne "iso.txt" && $file ne "." && $file ne ".." )
	    {
		require "$lang_dir/$lang_default/$file";
	    }
	}
	close(DIR);
    }

    ### load selected language string #####
    opendir (DIR, $lang_dir."/".current_lang() ) or die "Error";
    while ($file = readdir(DIR))
    {
	if ($file ne "iso.txt" && $file ne "." && $file ne ".." )
	{
	    require "$lang_dir/".current_lang()."/$file";
	}
    }
    close(DIR);
}



sub get_username {
  return("Admin");
}



######### get_addons  #########

sub get_addons
{
    my $file;
    my $line;
    my $type;
    my $addons_by_type;
    my $addon_enable;
    my $addon_name;
    my $addon_description;
    my $addon_icon;
    my $addon_version;
    my $addon_author;
    my $addon_type;
    my $addon_config;
    my $addon_config2;
    my $addon_clients;
    my $addon_secrets;
    my $addon_service;
    my $addon_program;
    
    if (!@html_output) {
     opendir (DIR, $addons_dir) or die $!;
     while ($file = readdir(DIR))
     {
 	if (($file ne ".") && ($file ne ".."))
	{
	    $addon_enable="true";
	    $addon_name="";
	    $addon_description="";
            $addon_icon="";
            $addon_version="1.0";
            $addon_author="Author";
            $addon_type="";
            $addon_config="";
            $addon_config2="";
            $addon_clients="";
            $addon_secrets="";
            $addon_service="";
            $addon_program="";
	    open(FR, "$addons_dir/$file") or die $!;
	    while ($line = <FR>)
	    {
		if ($line =~ /<name>/i)
		{
		    $addon_name = $line;
		    $addon_name =~ s|<.?name>||g;
		    $addon_name = substr($addon_name, 1);
		    chop($addon_name);
		}
		if ($line =~ /<description>/i)
		{
		    $addon_description = $line;
		    $addon_description =~ s|<.?description>||g;
		    $addon_description =~ s/^\s+|\s+$//g;
		}
		if ($line =~ /<icon>/i)
                {
                    $addon_icon = $line;
                    $addon_icon =~ s|<.?icon>||g;
                    $addon_icon =~ s/^\s+|\s+$//g;
                }

		if ($line =~ /<version>/i)
		{
		    $addon_version = $line;
		}
		if ($line =~ /<type>/i)
		{
		    $addon_type = $line;
		    $addon_type =~ s|<.?type>||g;
		    $addon_type = substr($addon_type, 1);
		    chop($addon_type);
		}
		if ($line =~ /<author>/i)
		{
		    $addon_author = $line;
		    $addon_author =~ s|<.?author>||g;
		    $addon_author = substr($addon_author, 1);
		    chop($addon_author);
		}
		if ($line =~ /<program>/i)
		{
		    $addon_program = $line;
		    $addon_program =~ s|<.?program>||g;
		    $addon_program = substr($addon_program, 1);
		    chop($addon_program);
		}
		if ($line =~ /<config>/i)
		{
		    $addon_config = $line;
		    $addon_config =~ s|<.?config>||g;
		    $addon_config = substr($addon_config, 1);
		    chop($addon_config);
		}
		if ($line =~ /<config2>/i)
		{
		    $addon_config2 = $line;
		    $addon_config2 =~ s|<.?config2>||g;
		    $addon_config2 = substr($addon_config2, 1);
		    chop($addon_config2);
		}
		if ($line =~ /<clients>/i)
		{
		    $addon_clients = $line;
		    $addon_clients =~ s|<.?clients>||g;
		    $addon_clients = substr($addon_clients, 1);
		    chop($addon_clients);
		}
		if ($line =~ /<secrets>/i)
		{
		    $addon_secrets = $line;
		    $addon_secrets =~ s|<.?secrets>||g;
		    $addon_secrets = substr($addon_secrets, 1);
		    chop($addon_secrets);
		}
		### systemd service files
		if ($line =~ /<service>/i)
		{
		    $addon_service = $line;
		    $addon_service =~ s|<.?service>||g;
		    $addon_service = substr($addon_service, 1);
		    chop($addon_service);
		}
                if ($line =~ /<enable>/i)
		{
 		    $addon_enable = $line;
		    $addon_enable =~ s|<.?enable>||g;
                    $addon_enable = substr($addon_enable, 1);
                    chop($addon_enable);
		    print $addon_enable;
 		}
	    }
	    ### push collected infos in %addons
   	     $addons{$addon_name}={name=>$addon_name, description=>$addon_description, icon=>$addon_icon, version=>$addon_version, author=>$addon_author, type=>$addon_type, program=>$addon_program, config=>$addon_config, config2=>$addon_config2, clients=>$addon_clients, secrets=>$addon_secrets, service=>$addon_service};

	    ### sort infos into categories
             if ($addon_type and $addon_enable ne "false") {
     	      push @{ $addons_by_type->{$addon_type}},{name=>$TEXT{$addon_description},icon=>$addon_icon,program=>$addon_program};
	     }  
	    close(FR);

	    ### Undefine variables for next run
	    undef($addon_name);
	    undef($addon_description);
	    undef($addon_icon);
	    undef($addon_version);
	    undef($addon_author);
	    undef($addon_type);
	    undef($addon_config);
	    undef($addon_config2);
	    undef($addon_clients);
	    undef($addon_secrets);
	    undef($addon_service);
	    undef($addon_program);
	}
    }
    closedir(DIR);
    foreach $type (sort keys %$addons_by_type) 
    {
     push(@html_output,{type=>$TEXT{$type},addons=>$addons_by_type->{$type}});
     push(@categories,$type);
    }
  }
}


######## users_info ###########
sub users_info
{
  my @userlist = `/usr/bin/cat /etc/passwd`;
  my $username;
  my $groups;
  my %users;
  my $uid;
  foreach (@userlist)
    {
        ($username,undef,$uid,undef,undef,undef,undef) = split(/:/,$_);
        $groups = `/usr/bin/sudo /usr/bin/id -Gn $username`;
        if (($uid > 999 ) && ($uid < 6500))
        {
            $users{$username}=[$uid,$groups];
        }
    }
   return(%users);
}


#### drive_status ######

sub drive_status
{
    my $disk;
    my $fs;
    my $size;
    my $pre_size;
    my $system;
    my $mount_dir=get_mount_dir();
    my %fs=fs_info();
    my @disks_errors;
    my $disks_errors;
    my %disks_errors;
    my %disks;
    my @disks = `/usr/bin/sudo /sbin/fdisk -l 2> /dev/null | /usr/bin/grep "Disk /dev"`;

    #### Check disks errors in Filesystems ######
    foreach $fs (keys %fs) {
	    #     @disks_errors=`/usr/bin/sudo /usr/sbin/btrfs device stats --check $mount_dir/$_ | grep -vE ' 0$' `;
     foreach $disks_errors (@disks_errors) {
      ($disk,undef)=split(/\./,$disks_errors);
      $disks_errors{$disk}=1;
     }
    }

    foreach (@disks)
    {
	(undef,$disk,$size,$pre_size,)=split(" ", $_);
	chop($disk);
	chop($pre_size);
	if (!(($disk =~ /\/dev\/ram/) or ($disk =~ /\/dev\/loop/)))
	{
            if (index(`/usr/bin/sudo /usr/bin/mount | grep "on / "`,$disk) != -1) 
            {
              $disks{$disk} = [$TEXT{'system'},$size,$pre_size]; 
            }
            else
            {
	      if (`/usr/bin/sudo /sbin/btrfs filesystem show | /usr/bin/grep $disk`)
	      {
                if (defined($disks_errors{"[$disk]"})) {
		 $disks{$disk} = [$TEXT{'failed'},$size,$pre_size];
                }
                else {
	  	 $disks{$disk} = [$TEXT{'used'},$size,$pre_size];
		}
	      }
	      else
	      {
  		$disks{$disk} = [$TEXT{'free'},$size,$pre_size];
	      }
	  }
       }
    }
    return %disks;
}



########## vol_info ##########
sub vol_info
{
  my %fs=fs_info();
  my %volumes;
  my @vol_info;
  my $id;
  my $du;
  my $vol;
  my $size;
  my $fs;

  foreach $fs (keys %fs)
  {
    @vol_info = `sudo /sbin/btrfs subvolume list $mount_dir/$fs`;
    foreach (@vol_info)
    {
       (undef,$id,undef,undef,undef,undef,undef,undef,$vol) = split(" ",$_);
       $du = `/usr/bin/sudo /usr/bin/du -h -a -c  $mount_dir/$fs/$vol | /usr/bin/tail -1`;
       ($size,undef) = split(" ",$du);
        $volumes{$fs."/".$vol}=[$fs,$vol,$id,$size];
    }
  }
 return(%volumes);
}


############ fs_info ###########
sub fs_info
{
 my $fs;
 my $uuid;
 my $health;
 my $mounted;
 my $raid;
 my $size=0;
 my $used=0;
 my $devices;
 my %filesystems;
 my @filesystem_list = `/usr/bin/sudo /sbin/btrfs filesystem show`;
 foreach (@filesystem_list)
    {
	### List by LABEL ?
	if($_ =~ m/Label:/)
	{
	    (undef,$fs,undef,$uuid)=split(" ", $_);
	    chop($fs);
	    $fs = substr($fs, 1);
            $health = $TEXT{'good'};
	}

       if ($_ =~ m/ Some devices missing/)
       {
        $health = $TEXT{'degraded'};
       }

       if($_ =~ m/Total/)
       {
	(undef,undef,$devices,undef,undef,undef,$used) = split(' ',$_);
       } 

	if (mounted($fs) eq "Mounted")

        {
           $mounted="Mounted";
	   $raid=raid_status($fs);
   	}
        else
        {
           $mounted="UnMounted";
	   $raid='';
        }


       if ($fs ne "ROOT" && $fs ne "BOOT")
       {
         $filesystems{$fs}=[$uuid,$health,$used,$devices,$mounted,$raid,get_compress_status($fs)];
       }
    }
    return (%filesystems);
}


########################### Main ############################

#### Check Environemnt
if  ( !-d $conf_dir) {
 mkdir($conf_dir, 0755)
}

if ( !-e $lang_conf) {
 open(FH, '>', $lang_conf) or die $!;
 print FH $lang_default;
 close(FH);
} 

get_lang_list;
load_language;
get_addons;


1;
