#!/bin/bash
#========================================================================
# easynas.sh
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

CHOOSE=""

while [[ true ]] ; do
    IP_ADDR=$(/usr/sbin/ip address | grep " inet " | cut -d'/' -f1 | awk '{print $2}' | grep -m 1 -v 127.0.0.1)
    INT=ifcfg-$(ls /sys/class/net/ | grep -v lo)
    INT_DIR=$(dirname $(sudo find /etc/sysconfig/ -name 'ifcfg-lo'))
    PORT=$(/bin/grep ExecStart /usr/lib/systemd/system/easynas.service | cut -d" " -f6 | grep -oP '(?<=[*])[^?]*')
    clear
    echo "#########################################"
    cat /etc/ImageVersion
    echo
    echo "#########################################"
    echo ""
    echo "Browse to https://$IP_ADDR$PORT to configure EasyNAS"
    echo ""
    echo ""
    echo "Admin Tasks:"
    echo ""
    echo " 1. Change admin password"
    echo " 2. Restart network"
    echo " 3. Reset to default settings"
    echo " 4. Check for EasyNAS updates"
    echo " 5. Restart"
    echo " 6. Shutdown"
    echo " 7. Shell"
    echo ""
    echo "Selection (1-7) :" 
    read CHOOSE

    case "$CHOOSE" in

	"1" )

	    read -s -p "Enter new password: " PASSWORD
	    echo admin:$PASSWORD | /usr/bin/sudo /usr/sbin/chpasswd
	    if [[ -f /usr/bin/smbpasswd ]]; then
		/usr/bin/printf "$PASSWORD\n$PASSWORD\n" | /usr/bin/sudo /usr/bin/smbpasswd -a -s admin 
	    fi
	    read -p "Press Enter key to continue ..."
	;;

	"2" )
	    read -p "Press Enter key to restart network"
	    sudo /usr/sbin/service network restart 
	    read -p "Press Enter key to continue ..."
	;;

	"3" )
	    read -p "Press Enter key to reset settings"
	    sudo /bin/tar -xf /easynas/startup/settings.tar -C /
	    sudo /bin/rm /etc/resolv.conf
	    sudo /easynas/startup/reset_network.sh
	    read -p "Press Enter key to restart EasyNAS ..."
	    sudo /usr/bin/systemctl reboot
	;;
	
	"4" )
	    sudo /usr/bin/zypper update easynas*
            read -p "Press Enter key to continue ..."
	;;


	"5" )
	    read -p "Press Enter key to restart EasyNAS ..."
	    sudo /usr/bin/systemctl reboot
	;;

	"6" )
	    read -p "Press Enter key to shutdown EasyNAS ..."
	    sudo /usr/bin/systemctl poweroff
	;;

	"7" )
	    /bin/bash
	;;

    esac

done

exit 0
