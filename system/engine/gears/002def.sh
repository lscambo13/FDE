#!/system/bin/sh
### FeraDroid Engine v0.20 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
LOG=/sdcard/Android/FDE.txt
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] 002 - ***Ad-block gear***" >> $LOG
$B echo "Updating hosts.." >> $LOG
$B mount -o remount,rw /system
$B rm -f /system/engine/assets/hosts
$B touch /system/engine/assets/hosts
$B chmod 777 /system/engine/assets/hosts
$B wget -O /system/engine/assets/hosts "http://winhelp2002.mvps.org/hosts.txt"
$B sed -i "s/#.*//" /system/engine/assets/hosts
$B sed -i "/^$/d" /system/engine/assets/hosts
$B sed -i -e "s/0.0.0.0/127.0.0.1/g" /system/engine/assets/hosts
$B cat /system/engine/assets/hosts > /system/etc/hosts
$B chmod 755 /system/etc/hosts
$B sleep 1
$B echo "Done." >> $LOG
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] 002 - ***Ad-block gear*** - OK" >> $LOG
sync;
