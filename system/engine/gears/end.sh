#!/system/bin/sh
### FeraDroid Engine v0.25 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox;
LOG=/sdcard/Android/FDE_log.txt;
SDK=$(getprop ro.build.version.sdk);
if [ -e $LOG ]; then
 $B echo "LOG - OK";
else
 LOG=/data/media/0/Android/FDE_log.txt;
fi;
$B echo "Allow mediaserver read write execute" >> $LOG;
supolicy --live "allow mediaserver mediaserver_tmpfs:file { read write execute };";
if [ "$SDK" -le "18" ]; then
 if [ "$SDK" -gt "10" ]; then
  $B echo "Mediaserver kill" >> $LOG;
  $B killall -9 android.process.media;
  $B killall -9 mediaserver;
 fi;
fi;
if [ -e /system/engine/prop/firstboot ]; then
 if [ -e /etc/fstab ]; then
  $B echo "FStab onboard.." >> $LOG;
 else
  $B cp /fstab.* /etc/fstab;
 fi;
 $B fsck -A -C -V -T | $B tee -a $LOG;
 $B echo "FStrim init.." >> $LOG;
 $B echo "Trim /system" >> $LOG;
 $B fstrim -v /system | $B tee -a $LOG;
 $B echo "Trim /data" >> $LOG;
 $B fstrim -v /data | $B tee -a $LOG;
 $B echo "Trim /cache" >> $LOG;
 $B fstrim -v /cache | $B tee -a $LOG;
 sync;
fi;
TIME=$($B date | $B awk '{ print $4 }');
$B echo "[$TIME] Applying FDE kernel configuration.." >> $LOG;
sysctl -p;
if [ -e /system/engine/bin/boost ]; then
 $B echo "Sleep, sync and free RAM" >> $LOG;
 /system/engine/bin/boost | $B tee -a $LOG;
fi;
TIME=$($B date | $B awk '{ print $4 }');
$B echo "[$TIME] END end" >> $LOG
