#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###

B=/system/engine/bin/busybox
LOG=/sdcard/Android/FDE.txt
TIME=$($B date | $B awk '{ print $4 }')

$B echo "" >> $LOG
$B echo "[$TIME] 002 - ***Ad-block gear***" >> $LOG
if [ -e /system/engine/prop/nohost ]; then
 $B echo "Hosts were not updated. Dealing.." >> $LOG
 $B mount -o remount,rw /system
 $B rm -f /system/etc/hosts
 $B cp /system/engine/assets/hosts /system/etc/hosts
 $B rm -f /system/engine/prop/nohost
 $B chmod 755 /system/etc/hosts
 $B sleep 1
fi;
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] 002 - ***Ad-block gear*** - OK" >> $LOG
sync;

