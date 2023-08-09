#!/bin/sh

wget_options="-q --no-check-certificate"

dl_path_folder=`/userfs/bin/tcapi get WebCustom_Entry webs_state_pathF`
if [ "$dl_path_folder" = "no attribute information" ] || [ "$dl_path_folder" = "" ]; then
	dl_path_SQ="https://dlcdnets.asus.com/pub/ASUS/LiveUpdate/Release/Wireless_SQ"
	dl_path_SQ_beta="https://dlcdnets.asus.com/pub/ASUS/LiveUpdate/Release/Wireless_SQ/app"
	dl_path_file="https://dlcdnets.asus.com/pub/ASUS/wireless/ASUSWRT"
else
	dl_path_SQ="https://dlcdnets.asus.com/pub/ASUS/LiveUpdate/Release/Wireless_SQ/${dl_path_folder}"
	dl_path_SQ_beta="https://dlcdnets.asus.com/pub/ASUS/LiveUpdate/Release/Wireless_SQ/${dl_path_folder}/app"
	dl_path_file="https://dlcdnets.asus.com/pub/ASUS/wireless/ASUSWRT/${dl_path_folder}"
fi

echo "---- To download fw/rsa, Start ----" > /tmp/webs_upgrade.log
# INITIALIZING
/userfs/bin/tcapi set WebCustom_Entry webs_state_upgrade 0 &
/userfs/bin/tcapi set WebCustom_Entry webs_state_error 0 &
/userfs/bin/tcapi set WebCustom_Entry webs_state_error_msg "" &
/userfs/bin/tcapi set WebCustom_Entry webs_rsa_state_upgrade 0 &

get_productid=`/userfs/bin/tcapi get SysInfo_Entry ProductName | sed s/+/plus/;`    #replace 'plus' to '+' for one time
odmpid_support=`/userfs/bin/tcapi get WebCustom_Entry webs_state_odm`
if [ "$odmpid_support" = "1" ]; then
	get_productid=`/userfs/bin/tcapi get SysInfo_Entry odmpid | sed s/+/plus/;`    #replace 'plus' to '+' for one time
fi
file_name_postfix=`tcapi get WebCustom_Entry webs_state_fName`

if [ "$file_name_postfix" = "no attribute information" ] || [ "$file_name_postfix" = "" ]; then
	firmware_file=`echo $get_productid`_`/userfs/bin/tcapi get WebCustom_Entry webs_state_info`.zip
	firmware_rsasign=`echo $get_productid`_`/userfs/bin/tcapi get WebCustom_Entry webs_state_info`_rsa.zip
else	#with file name postfix
	firmware_file=`echo $get_productid`_`/userfs/bin/tcapi get WebCustom_Entry webs_state_info`_${file_name_postfix}.zip
	firmware_rsasign=`echo $get_productid`_`/userfs/bin/tcapi get WebCustom_Entry webs_state_info`_${file_name_postfix}_rsa.zip
fi

firmware_path="/var/tmp/tclinux.bin"
rsa_path="/var/tmp/rsasign.bin"

rm -rf $firmware_path &
rm -rf $rsa_path &

# for sq
forsq=`/userfs/bin/tcapi get Apps_Entry apps_sq`
if [ -z "$forsq" ]; then
	forsq=0
fi

url_path=`/userfs/bin/tcapi get WebCustom_Entry webs_state_url`

# get firmware information
dl_fw=""
dl_rsa=""
echo 3 > /proc/sys/vm/drop_caches
if [ "$forsq" = "1" ]; then
	echo "---- sq path upgrade HTTPS----" >> /tmp/webs_upgrade.log
	echo "${dl_path_SQ}/$firmware_file" >> /tmp/webs_upgrade.log
	wget ${wget_options} ${dl_path_SQ}/$firmware_file -O ${firmware_path}
	dl_fw="$?"
	wget ${wget_options} ${dl_path_SQ}/$firmware_rsasign -O ${rsa_path}
	dl_rsa="$?"
elif [ "$url_path" = "" ]; then
	echo "---- Official path upgrade HTTPS----" >> /tmp/webs_upgrade.log
	echo "${dl_path_file}/$firmware_file" >> /tmp/webs_upgrade.log
	wget ${wget_options} ${dl_path_file}/$firmware_file -O ${firmware_path}
	dl_fw="$?"
	wget ${wget_options} ${dl_path_file}/$firmware_rsasign -O ${rsa_path}
	dl_rsa="$?"
else
	echo "---- External URL path upgrade HTTPS----" >> /tmp/webs_upgrade.log
	echo "$url_path/$firmware_file" >> /tmp/webs_upgrade.log
	wget ${wget_options} $url_path/$firmware_file -O ${firmware_path}
	dl_fw="$?"
	wget ${wget_options} $url_path/$firmware_rsasign -O ${rsa_path}
	dl_rsa="$?"
fi

echo "---- download firmware exit: $dl_fw ; download rsa exit: $dl_rsa ----" >> /tmp/webs_upgrade.log
if [ "$dl_fw" != "0" ]; then
	/userfs/bin/tcapi set WebCustom_Entry webs_state_error 1 &
	/userfs/bin/tcapi set WebCustom_Entry webs_state_error_msg "download firmware fail" &
	echo "---- download firmware fail ----" >> /tmp/webs_upgrade.log
elif [ "$dl_rsa" != "0" ]; then
	/userfs/bin/tcapi set WebCustom_Entry webs_state_error 1 &
	/userfs/bin/tcapi set WebCustom_Entry webs_state_error_msg "download rsa fail" &
	echo "---- download rsa fail ----" >> /tmp/webs_upgrade.log
else
	echo 3 > /proc/sys/vm/drop_caches
	/userfs/bin/tcapi set WebCustom_Entry webs_state_error_msg "download firmware successfully" &
	echo "---- download fw/rsa succesfully ----" >> /tmp/webs_upgrade.log
fi
echo "---- download firmware/rsa end ----" >> /tmp/webs_upgrade.log
/userfs/bin/tcapi set WebCustom_Entry webs_state_upgrade 1 &
/userfs/bin/tcapi set WebCustom_Entry webs_rsa_state_upgrade 1 &
