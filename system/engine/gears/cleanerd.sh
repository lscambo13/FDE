#!/system/bin/sh
### FeraDroid Engine v1.1 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox;
if [ -d /sdcard/Android/ ]; then
 LOG=/sdcard/Android/FDE_log.txt;
else
 LOG=/data/media/0/Android/FDE_log.txt;
fi;
while true; do
 $B echo "Cleaner daemon is active." >> $LOG;
 $B sleep 172800;
 sync;
 $B sleep 1;
 $B echo "3" > /proc/sys/vm/drop_caches;
 $B sleep 1;
 sync;
 $B sleep 1;
 /system/engine/gears/cleaner.sh;
done;

