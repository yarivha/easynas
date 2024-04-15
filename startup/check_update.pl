#! /usr/bin/perl -w 
#========================================================================
# check_update.sh
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
# This file is part of EasyNAS (c) created by Yariv Hakim 2012-2021
#
# Homepage    : https://www.easynas.org
#
#########################################################################

use lib '.';
use XML::LibXML;

##### Declaration ####
my $addons="/etc/easynas/easynas.addons";
my $package;
my $dom;
my $fh;

####### Refresh Repo #######
`/usr/bin/sudo /usr/bin/zypper --quiet --gpg-auto-import-keys refresh`;
`/usr/bin/sudo /usr/bin/zypper --quiet --xmlout search easynas | /usr/bin/sudo /usr/bin/tee /etc/easynas/easynas.addons`;
`/usr/bin/sudo /usr/bin/zypper --quiet --xmlout lu -a --repo EasyNAS | /usr/bin/sudo /usr/bin/tee  /etc/easynas/easynas.updates`;
if (-e $addons) {
  open my $fh, '<', $addons;
  binmode $fh; # drop all PerlIO layers possibly created by a use open pragma
  $dom = XML::LibXML->load_xml(IO => $fh);
  foreach $addon ($dom->findnodes('/stream/search-result/solvable-list/solvable')) {
    $package=$addon->findvalue('./@name');
    $package =~ s/^\s+//;
    if ($package =~ /easynas/) 
    {
     `sudo /usr/bin/zypper --xmlout info $package | /usr/bin/tee /etc/easynas/$package.addon`;
    }
  }
}

exit;
