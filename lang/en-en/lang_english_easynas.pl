
# lang_english_easynas.pl
# Version 1.2.0
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
# This file is part of EasyNAS (c) created by Yariv Hakim 2012-2022
#
# Homepage    : https://www.easynas.org
#
#########################################################################


$TEXT{'easynas'} = "EasyNAS";
$TEXT{'yariv'} = "Yariv Hakim";
$TEXT{'username'} = "Username";
$TEXT{'password'} = "Password";
$TEXT{'please_wait'} = "Please Wait....";
$TEXT{'not_authorized'} = "You are not authorize to use this function";
$TEXT{'edit'} = "Edit";
$TEXT{'delete'} = "Delete";
$TEXT{'about'} = "About";
$TEXT{'save'} = "Save";
$TEXT{'reset'} = "Reset";
$TEXT{'create'} = "Create";
$TEXT{'add'} = "Add";
$TEXT{'performance'} = "Performance";
$TEXT{'about_help'} = "
<h1><center>EasyNAS</center></h1><br>
<h3><center>Version ".easynas_ver()."</center></h3><br>
<h4><center>Running on ".easynas_hardware()."</center></h4><br>
<center>Copyright &copy; 2013-2023</center><br>
<h4><center><a href=\"https://www.easynas.org\"  target=\"new\" >https://www.easynas.org</a></center><h4>";



######  Menu ######
$TEXT{'dashboard'} = "Dashboard";
$TEXT{'multimedia'} = "MultiMedia";
$TEXT{'realm'} = "Realm";
$TEXT{'sharing'} = "File Sharing";
$TEXT{'services'} = "Services";
$TEXT{'storage'} = "Storage";
$TEXT{'system'} = "System";

######  Dashboard ######
$TEXT{'dashboard_view_details'} = "View Details";
$TEXT{'dashboard_drives'} = "Drives";
$TEXT{'dashboard_filesystems'} = "File Systems";
$TEXT{'dashboard_users'} = "Users";
$TEXT{'dashboard_volumes'} = "Volumes";
$TEXT{'dashboard_disk'} = "Disk";
$TEXT{'dashboard_filesystem'} = "File System";
$TEXT{'dashboard_failed'} = "Failed";
$TEXT{'dashboard_used'} = "Used";
$TEXT{'dashboard_system'} = "System";
$TEXT{'dashboard_free'} = "Free";
$TEXT{'dashboard_good'} = "Good";
$TEXT{'dashboard_degreded'} = "Degraded";
$TEXT{'dashboard_update_available'} = "New updates available";
$TEXT{'dashboard_click_here'} = " click here to update";

#### Search ####
$TEXT{'search'} = "Search";

#### System Info ####
$TEXT{'sysinfo'} = "System Info";
$TEXT{'cpu'} = "CPU";
$TEXT{'vendor'} = "Vendor";
$TEXT{'model'} = "Model";
$TEXT{'cache_size'} = "Cache Size";
$TEXT{'speed'} = "Speed";
$TEXT{'os'} = "OS";
$TEXT{'architecture'} = "Architecture";
$TEXT{'firmware'} = "Firmware";
$TEXT{'filesystem'} = "FileSystem";
$TEXT{'memory'} = "Memory";
$TEXT{'total_memory'} = "Total Memory";
$TEXT{'free_memory'} = "Free Memory";
$TEXT{'total_swap_memory'} = "Total Swap Memory";
$TEXT{'free_swap_memory'} = "Free Swap Memory";

#### Settings ####
$TEXT{'general_settings'} = "General Settings";
$TEXT{'bad_system_port'} = "Bad System Port";
$TEXT{'bad_secure_port'} = "Bad Secure Port";
$TEXT{'bad_web_port'} = "Bad Web Port";
$TEXT{'settings'} = "Settings";
$TEXT{'date_time'} = "Date / Time";
$TEXT{'access_list'} = "Access List";
$TEXT{'host_name'} = "Host Name";
$TEXT{'system_port'} = "System Port";
$TEXT{'secure_port'} = "System Secure Port";
$TEXT{'change_settings_in_progress'} = "Change Settings in Progress....";
$TEXT{'certificate'} = "Certificate";
$TEXT{'cert_details'} = "Certificate Details";
$TEXT{'no_cert'} = "No Certificate found";
$TEXT{'bad_cert'} = "Bad Certificate";
$TEXT{'upload'} = "Upload";
$TEXT{'error_updating_date'} = "Error updating Date / Time";
$TEXT{'error_settings_demo'} = "Can not change settings in a demo site";
$TEXT{'repositories'} = "Repositories";
$TEXT{'repository'} = "Repository";
$TEXT{'enabled'} = "Enabled";
$TEXT{'disabled'} = "Disabled";
$TEXT{'enable'} = "Enable";
$TEXT{'disable'} = "Disable";

#### User Profile ####
$TEXT{'user_profile'} = "User Profile";



#### Backup ####
$TEXT{'backup_restore'} = "Backup & Restore";
$TEXT{'backup'} = "Backup";
$TEXT{'restore'} = "Restore";
$TEXT{'file_name'} = "File Name";
$TEXT{'backup_failed'} = "Backup Failed";
$TEXT{'backup_completed'} = "Backup completed successfully";
$TEXT{'restore_failed'} = "Restore Failed";
$TEXT{'testore_completed'} = "Restore Completed";

#### Network settings ####
$TEXT{'network_setting'} = "Network Settings";
$TEXT{'error_ip_demo'} = "Can't change IP in a demo site";
$TEXT{'network_restart'} = "Restart EasyNAS server for the changes to take place.";

#### Scheduler ##########
$TEXT{'scheduler'} = "Scheduler";
$TEXT{'snapshots'} = "Snapshots";
$TEXT{'syncs'} = "Remote Syncs";
$TEXT{'scrubs'} = "File Systems Scrub";
$TEXT{'powers'} = "Power Control";
$TEXT{'create_sc'} = "Create Schedule";
$TEXT{'schedule_snapshot'} = "Schedule Snapshot";
$TEXT{'schedule_sync'} = "Schedule Remote Sync";
$TEXT{'schedule_scrub'} = "Schedule Scrub";
$TEXT{'schedule_power'} = "Schedule Power Control";
$TEXT{'no_vol_selected'} = "No Volume was selected";
$TEXT{'sc_exists'} = "Schedule name already exists";
$TEXT{'control_type'} = "Control Type";
$TEXT{'error_restarting_sc'} = "Error restarting scheduler";
$TEXT{'delete_sc'} = "Delete Schedule";
$TEXT{'error_deleting_sc'} = "Error deleting scheduler";
$TEXT{'update_sc'} = "Update Schedule"; 
$TEXT{'sc_name'} = "Schedule Name";
$TEXT{'remote_system'} = "Remote System";
$TEXT{'time'} = "Time";
$TEXT{'date'} = "Date";
$TEXT{'day_of_week'} = "Day of week";
$TEXT{'sc'} = "SCHEDULE";
$TEXT{'scs'} = "Schedules";
$TEXT{'sc_name'} = "Name";
$TEXT{'sc_task'} = "Task";
$TEXT{'vol_name'} = "Volume Name";
$TEXT{'fs_name'} = "FileSystem Name";
$TEXT{'fs_delete'} = "Delete FileSystem";
$TEXT{'weekday'} = "WeekDay";
$TEXT{'delete_sc?'} = "Are you sure you want to delete the schedule ?";

### NETWORK ###
$TEXT{'network_settings'} = "Network Settings";
$TEXT{'network_interfaces'} = "Network Interface";
$TEXT{'interface'} = "Interface";
$TEXT{'state'} = "State";
$TEXT{'broadcast'} = "Broadcast";
$TEXT{'net_mask'} = "Mask";
$TEXT{'hardware_mac'} = "MAC-Address";
$TEXT{'dhcp'} = "DHCP";
$TEXT{'static'} = "Static";
$TEXT{'ip_address'} = "IP-Address";
$TEXT{'subnet_mask'} = "Subnet Mask";
$TEXT{'gateway'} = "Gateway";
$TEXT{'domain'} = "Domain";
$TEXT{'pri_dns'} = "Primary DNS";
$TEXT{'sec_dns'} = "Secondary DNS";
$TEXT{'state_up'} = "Up";
$TEXT{'state_down'} = "Down";
$TEXT{'error_ip_demo'} = "Can't change IP in a demo site";
$TEXT{'network_restart'} = "Restart EasyNAS server for the changes to take place.";

#### Realm ####
$TEXT{'computers'} = "Computers";
$TEXT{'computers_manager'} = "Computers Manager";



#### Monitor ####
$TEXT{'cpu'} = "CPU";
$TEXT{'memory'} = "Memory";
$TEXT{'disk_io'} = "Disk IO";
$TEXT{'network_band'} = "Network Bandwitdh";


#### Power Managment ####
$TEXT{'power_management'} = "Power Management";
$TEXT{'shutdown_restart'} = "Shutdown / Restart";
$TEXT{'error_restart_demo'} = "Can't Restart in a demo site";
$TEXT{'restart_system'} = "Restarting System......";
$TEXT{'error_shutdown_demo'} = "Can't Shutdown in a demo site";
$TEXT{'shutdown_system'} = "Shuting Down System.....";
$TEXT{'execute_immediately'} = "Execute system Restart/Shutdown immediately.";
$TEXT{'restart'} = "Restart";
$TEXT{'shutdown'} = "Shutdown";
$TEXT{'close_service'} = "Closing Services.....";
$TEXT{'close_fs'} = "Unmounting FileSystems.....";
$TEXT{'restart_are_u_sure'} = "Are you sure you want to restart ?";
$TEXT{'restart_help'} = "You are about to Restart EasyNAS<br>
                         Please save all your files and close open services<br><br>
			 Press Restart when ready";
$TEXT{'shutdown_help'} = "You are about to Shutdown EasyNAS<br>
                         Please save all your files and close open services<br><br>
                         Press Shutdown when ready";

#### Firmware ####
$TEXT{'addons'} = "Addons";
$TEXT{'addon_installed'} = "Addon installed successfully";
$TEXT{'addon_not_installed'} = "Error installing addon";
$TEXT{'addon_deleted'} = "Addon deleted successfully";
$TEXT{'addon_not_deleted'} = "Error deleting Addon";
$TEXT{'addon_updated'} = "Addon updated successfully";
$TEXT{'addon_not_updated'} = "Error updating addon";
$TEXT{'firmware_upgrade'} = "Firmware Upgrade";
$TEXT{'firmware'} = "Firmware";
$TEXT{'lang'} = "Language";
$TEXT{'other_apps'} = "Other Apps";
$TEXT{'component'} = "Component";
$TEXT{'author'} = "Author";
$TEXT{'version'}="Version";
$TEXT{'current_version'}="Current Version";
$TEXT{'new_version'}="New Version";
$TEXT{'package_name'} = "Package Name";
$TEXT{'update'} = "Update";
$TEXT{'refresh'} = "Refresh";
$TEXT{'refresh_failed'} = "Refresh Failed";
$TEXT{'installed_version'} = "Installed Version";
$TEXT{'current_version'} = "Current Version";
$TEXT{'install'} = "Install";
$TEXT{'upgrade'} = "Upgrade";
$TEXT{'uninstall'} = "UnInstall";
$TEXT{'install_addon'} = "Install Addon";
$TEXT{'uninstall_addon'} = "UnInstall Addon";
$TEXT{'upgrade_addon'} = "Upgrade Addon";
$TEXT{'check_for_update'} = "Check for Update";
$TEXT{'cheking_firmware_availble'} = "Checking for available firmware: ";
$TEXT{'latest_firmware'} = "Your system is already in the latest firmware available";
$TEXT{'download_latest_version_here'} = "Download latest version from <a href=http://www.easynas.org/download target=New_Page>here</a>";
$TEXT{'upgrade_in_progress'} = "Upgrade In progress.........";
$TEXT{'downloading_firmware'} = "Downloading firmware.......";
$TEXT{'installing_new_firmware'} = "Installing new firmware......";
$TEXT{'firmware_upgraded'}="Firmware Upgraded";
$TEXT{'error_upgrading'}="Error Upgrading, please try again later";
$TEXT{'error_connecting'}="Error Connecting to EasyNAS repository, please try again later";
$TEXT{'failed_to_refresh_repo'}="Failed to refresh EasyNAS repository. Try again later";
$TEXT{'failed_to_install_addon'} = "Failed to install addon";
$TEXT{'refresh_repo'}="Refresh Repository";
$TEXT{'failed_to_delete_addon'} = "Failed to delete addon";
$TEXT{'install_addon?'} = "Install Addon ?";
$TEXT{'update_addon?'} = "Update Addon ?";
$TEXT{'delete_addon?'} = "Delete Addon ?";
$TEXT{'update_all'} = "Update All";
$TEXT{'firmware_update_available'} = "New updates available";
$TEXT{'firmware_here'} = " click here to update";
$TEXT{'firmware_refreshed'} = "Repositories refreshed";


#### Disk ####
$TEXT{'free'} = "Free";
$TEXT{'used'} = "Used";
$TEXT{'system'} = "System";
$TEXT{'failed'} = "Failed";
$TEXT{'disk_manager'} = "Disk Manager";
$TEXT{'disk_performace'} = "Disk Performace";
$TEXT{'testing'} = "Testing";
$TEXT{'rerun_test'} = "ReRun Test";
$TEXT{'disk_performance_help'} = "Disk performace test will check the read performace of a disk.";
$TEXT{'error_updating_param'} = "Error updating disk parameters";
$TEXT{'error_formating_disk'} = "Error Formating Disk";
$TEXT{'disk_format_success'} = "Disk formatted successfully";
$TEXT{'disk_update_success'} = "Disk updated successfully";
$TEXT{'physical_disks'} = "Physical Disks";
$TEXT{'disk'} = "Disk";
$TEXT{'size'} = "Size";
$TEXT{'status'} = "Status";
$TEXT{'model_number'} = "Model Number";
$TEXT{'serial_number'} = "Serial Number";
$TEXT{'firmware_version'} = "Firmware Version";
$TEXT{'actions'} = "Actions";
$TEXT{'disk_format_are_u_sure'} = "Are you sure you want to format disk ?";
$TEXT{'disk_test_are_u_sure'} = "Are you sure you want to test disk ?";
$TEXT{'disk_format'} = "Format";
$TEXT{'test_performance'} = "Test Performance";
$TEXT{'disk_distribution'} = "Disk Distribution";
$TEXT{'disk_settings'} = "Disk Settings";
$TEXT{'multi_count'} = "Multi Count:";
$TEXT{'io_supprt'} = "IO Support:";
$TEXT{'read_only'} = "Read Only:";
$TEXT{'read_ahead'} = "Read Ahead:";

#### File System ####
$TEXT{'fs'} = "File System";
$TEXT{'cancel'} = "Cancel";
$TEXT{'resume'} = "Resume";
$TEXT{'snapshot'} = "Snapshot";
$TEXT{'filesystems'} = "File Systems";
$TEXT{'fs_manager'} = "File System Manager";
$TEXT{'better'} = "Better";
$TEXT{'faster'} = "Faster";
$TEXT{'none'} = "None";
$TEXT{'health'} = "Health";
$TEXT{'good'} = "Good";
$TEXT{'degreded'} = "Degraded";
$TEXT{'mount'} = "Mount";
$TEXT{'unmount'} = "UnMount";
$TEXT{'fs_name'} = "File System Name";
$TEXT{'remove_hd'} = "Remove HD";
$TEXT{'replace_hd'} = "Replace HD";
$TEXT{'source_hd'} = "Source HD";
$TEXT{'target_hd'} = "Target HD";
$TEXT{'failed_to_remove_hd'} = "Failed to remove HD";
$TEXT{'fs_hd_removed'} = "HD removed succesfully";
$TEXT{'fs_hd_added'} = "HD added succesfully";
$TEXT{'fs_hd_replaced'} = "HD replaced succesfully";
$TEXT{'fs_failed_to_replace'} = "Failed to replace HD";
$TEXT{'add_hd'} = "Add HD";
$TEXT{'failed_to_add_HD'} = "Failed to add HD";
$TEXT{'repair_hd'} = "Repair HD";
$TEXT{'fs_need_to_be_unmounted'} = "File System need to be unmounted";
$TEXT{'fs_need_to_be_mounted'} = "File System need to be mounted";
$TEXT{'check&repair_hd'} = "Check & Repair HD";
$TEXT{'create_fs'} = "Create File System";
$TEXT{'fs_deleted'} = "FileSystem Deleted Succesfuly";
$TEXT{'no_disks_were_selected'} = "No Disks were selected";
$TEXT{'no_fs_name_was_entered'} = "No File System name was entered";
$TEXT{'reserved_fs'} = "ROOT is a reserved name";
$TEXT{'raid_0_require_two'} = "Raid 0 requires at least two drives";
$TEXT{'raid_1_require_two'} = "Raid 1 requires at least two drives";
$TEXT{'raid_10_require_four'} = "Raid 10 requires at least four drives";
$TEXT{'raid_5_require_three'} = "Raid 5 requires at least three drives";
$TEXT{'raid_6_require_four'} = "Raid 6 requires at least four drives";
$TEXT{'raid_the_same'} = "Raid level is the same, no action required.";
$TEXT{'raid_require_force'} = "Moving between Raid level will reduce integrity, you must force this change.";
$TEXT{'failed_creating_directory'} = "Failed creating a directory.";
$TEXT{'failed_creating_fs'} = "Failed creating a file system.";
$TEXT{'failed_mounting_fs'} = "Failed mounting a file system.";
$TEXT{'mount_fs'} = "Mount File System";
$TEXT{'unmount_fs'} = "Unmount File System";
$TEXT{'fs_failed_unmounting_fs'} = "Failed unmounting a file system.";
$TEXT{'no_free_disk'} = "No Free Disks Available";
$TEXT{'fs_name'} = "Name";
$TEXT{'raid_profile'} = "Raid Profile";
$TEXT{'compression'} = "Compression";
$TEXT{'disks'} = "Disks";
$TEXT{'ssd_optimization'} = "SSD Optimization";
$TEXT{'auto_mount'} = "Auto Mount";
$TEXT{'auto_defrag'} = "Auto Defrag";
$TEXT{'mount_option'} = "Mount Options";
$TEXT{'file_system_name'} = "File System Name";
$TEXT{'fs_raidlevel'} = "Raid Level";
$TEXT{'raid_profile'} = "Raid Profile";
$TEXT{'force_raid_change'} = "Force Raid Change";
$TEXT{'change_raid'} = "Change Raid";
$TEXT{'fs_change_name'} = "Change Name";
$TEXT{'fs_mount_options'} = "Mount Options";
$TEXT{'fs_disks'} = "Disks";
$TEXT{'number'} = "Number";
$TEXT{'disk'} = "Disk";
$TEXT{'total_size'} = "Total Size";
$TEXT{'used'} = "Used";
$TEXT{'status'} = "Status";
$TEXT{'remove_hd?'} = "Are you sure you want to remove the hardisk ?";
$TEXT{'repair_hd?'} = "Are you sure you want to repair the hardisk ?";
$TEXT{'check_repair_complete'} = "Check & Repair completed";
$TEXT{'add_hd'} = "Add Hard Disk";
$TEXT{'no_free_disks_available'} = "No Free Disks Available";
$TEXT{'drives'} = "Drives";
$TEXT{'fs_limit'} = "File System Quota Limit";
$TEXT{'0_no_limit'} = "(Enter 0 for no limits)";
$TEXT{'failed_limit'} = "Failed limiting quota on filesystem";
$TEXT{'filesystem_contain_vol'} = "File System Contain Volumes";
$TEXT{'filesystem_not_changed'} = "File System name was not changed";
$TEXT{'fs_created'} = "File System successfuly Created";


#### Volumes ####
$TEXT{'vol_manager'} = "Volume Manager";
$TEXT{'create_vol'} = "Create Volume";
$TEXT{'no_vol_name'} = "No Volume name was entered";
$TEXT{'no_fs_selected'} = "No File System was selected";
$TEXT{'delete_vol'} = "Delete Volume";
$TEXT{'faild_to_delete_vol'} = "Failed to delete volume";
$TEXT{'create_snapshot'} = "Create Snapshot";
$TEXT{'no_snapshot_name'} = "No Snapshot name was entered";
$TEXT{'failed_to_add_snapshot'} = "Failed to add snapshot";
$TEXT{'failed_to_change_owner'} = "Failed to change owner";
$TEXT{'failed_to_change_permission'} = "Failed to change permission";
$TEXT{'vol_name'} = "Volume Name";
$TEXT{'user_owner'} = "User Owner";
$TEXT{'group_owner'} = "Group Owner";
$TEXT{'user_permission'} = "User Permission";
$TEXT{'group_permission'} = "Group Permission";
$TEXT{'others_permission'} = "Others Permissions";
$TEXT{'snapshot_name'} = "Snapshot Name";
$TEXT{'vols'} = "Volumes";
$TEXT{'vol'} = "Volume";
$TEXT{'id'} = "ID";
$TEXT{'vol_name'} = "Volume Name";
$TEXT{'size'} = "Size";
$TEXT{'delete_vol?'} = "Are you sure you want to delete the volume ?";
$TEXT{'no_schedule_name'} = "No schedule name was entered.";
$TEXT{'failed_add_vol'} = "Failed adding a volume.";
$TEXT{'group_created'} = "Group created successfully";
$TEXT{'group_deleted'} = "Group deleted successfully";


#### Sync ####
$TEXT{'sync'} = "Sync Volumes";
$TEXT{'hostname'} = "Host name";
$TEXT{'rdir'} = "Remote Directory";
$TEXT{'password'} = "Password";
$TEXT{'sync_option'} = "Sync Option";
$TEXT{'sync_complete'} = "Sync Completed";
$TEXT{'failed_to_sync'} = "Failed to Sync";
$TEXT{'sync_could_not_connect'} = "Could not connect to RSync server";
$TEXT{'sync_bad_user_password'} = "Failed to Sync - Bad username or password";
$TEXT{'no_hostname'} = "Hostname was not enterd";
$TEXT{'no_rdir'} = "Remote dir was not enterd";
$TEXT{'no_vol'} = "Volume was not selected";

#### Users ####
$TEXT{'users_manager'} = "Users Manager";
$TEXT{'create_user'} = "Create User";
$TEXT{'passwords_do_not_match'} = "Passwords do not match.";
$TEXT{'admin_account'} = "Administration Account";
$TEXT{'all_groups'} = "All Groups";
$TEXT{'failed_to_add_user'} = "Failed to add user";
$TEXT{'failed_to_change_password'} = "Failed to change password";
$TEXT{'failed_to_add_samba_user'} = "Failed to add Samba User";
$TEXT{'delete_user'} = "Delete User";
$TEXT{'user_admin_cant_be_delete'} = "User admin can't be deleted.";
$TEXT{'user_admin_cant_be_changed'} = "User admin can't be changed.";
$TEXT{'failed_to_delete_user'} = "Failed to delete user";
$TEXT{'cant_change_admin_password'} = "Can't change admin password in a demo site";
$TEXT{'passwords_do_not_match'} = "Passwords do not match";
$TEXT{'password_must_exist'} = "Password must exist";
$TEXT{'change_password'} = "Change Password";
$TEXT{'one_group_needed'} = "At least one group is required";
$TEXT{'failed_to_change_samba_password'} = "Failed to change Samba password";
$TEXT{'failed_to_delete_samba_user'} = "Failed to delete Samba user";
$TEXT{'change_settings'} = "Change Settings";
$TEXT{'failed_to_change_settings'} = "Failed to change settings.";
$TEXT{'users'} = "Users";
$TEXT{'user_name'} = "User Name";
$TEXT{'name'} = "Name";
$TEXT{'desc'} = "Description";
$TEXT{'uid'} = "UID";
$TEXT{'group'} = "Group";
$TEXT{'groups'} = "Groups";
$TEXT{'password'} = "Password";
$TEXT{'password_again'} = "Password Again";
$TEXT{'easynas_admin'} = "EasyNAS Admin";
$TEXT{'delete_user?'} = "Are you sure you want to delete the user ?";
$TEXT{'user_settings'} = "USER SETTINGS";
$TEXT{'user_created'} = "User created successfully";
$TEXT{'user_deleted'} = "User deleted successfully"; 



#### Groups ####
$TEXT{'groups_manager'} = "Groups Manager";
$TEXT{'create_group'} = "Create Group";
$TEXT{'failed_to_add_group'} = "Failed to add the group";
$TEXT{'delete_group'} = "Delete Group";
$TEXT{'group'} = "Group";
$TEXT{'groups'} = "Groups";
$TEXT{'can_not_deleted'} = "can't be deleted";
$TEXT{'failed_to_delete_group'} = "Failed to delete the group";
$TEXT{'group_name'} = "Group Name";
$TEXT{'access_permission'} = "Access Permission";
$TEXT{'groups_settings'} = "Groups Settings";
$TEXT{'gid'} = "GID";
$TEXT{'delete_group?'} = "Are you sure you want to delete the group ?";

#### Security ####
$TEXT{'security'} = "Security";
$TEXT{'access_control'} = "Access Control";
$TEXT{'security_help'} = "";
$TEXT{'enter_ip_or_network'} = "Enter the IP address or network from with the connections to this server will be allowed or rejected";
$TEXT{'error_security_demo'} = "Can't change ACL in a demo site";
