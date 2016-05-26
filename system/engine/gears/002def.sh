#!/system/bin/sh
### FeraDroid Engine v0.21 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] 002 - ***Ad-block gear***"
$B echo "Updating hosts.."
$B mount -o remount,rw /system
$B rm -f /system/engine/assets/hosts
$B touch /system/engine/assets/hosts
$B chmod 777 /system/engine/assets/hosts
$B wget -q --tries=10 --timeout=20 --spider  "http://winhelp2002.mvps.org/hosts.txt"
if [[ $? -eq 0 ]]; then
 $B echo "We are Online"
 $B wget -O /system/engine/assets/hosts "http://winhelp2002.mvps.org/hosts.txt"
 $B sed -i "s/#.*//" /system/engine/assets/hosts
 $B sed -i "/^$/d" /system/engine/assets/hosts
 $B sed -i -e "s/0.0.0.0/127.0.0.1/g" /system/engine/assets/hosts
 $B cat /system/engine/assets/hosts > /system/etc/hosts
 $B chmod 755 /system/etc/hosts
else
 $B echo "We are Offline"
fi;
$B sleep 1
$B echo "Done."
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] 002 - ***Ad-block gear*** - OK"
sync;
