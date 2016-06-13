#!/system/bin/sh
### FeraDroid Engine v0.21 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] ***Ad-blocker gear***"
$B wget -q --tries=9 --timeout=10 --spider  "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-porn-social/hosts"
if [ $? -eq 0 ]; then
 $B echo "We are Online"
 $B echo "Updating hosts.." 
 $B mount -o remount,rw /system
 $B rm -f /system/engine/assets/hosts
 $B touch /system/engine/assets/hosts
 $B chmod 777 /system/engine/assets/hosts
 $B wget -O /system/engine/assets/hosts "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-porn-social/hosts"
 $B sed -i "s/#.*//" /system/engine/assets/hosts
 $B sed -i "/^$/d" /system/engine/assets/hosts
 $B sed -i -e "s/0.0.0.0/127.0.0.1/g" /system/engine/assets/hosts
 $B cat /system/engine/assets/hosts > /system/etc/hosts
 $B chmod 755 /system/etc/hosts
 $B echo "Done."
else
 $B echo "We are Offline"
fi;
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] ***Ad-blocker gear*** - OK"
sync;
