#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###

B=/system/engine/bin/busybox
SH=/system/engine/bin/sh
LOG=/sdcard/Android/FDE.txt
TIME=$($B date | $B awk '{ print $4 }')
KERNEL=$($B uname -a)
ROM=$(getprop ro.build.display.id)
SDK=$(getprop ro.build.version.sdk)

mount -o remount,rw /system
chmod -R 777 /system/engine/bin/*
setprop ro.feralab.engine 19
if [ -e /engine.sh ]; then
 $B sleep 45
else
 $B sleep 18
fi;

$B rm -f $LOG
$B touch $LOG
$B echo "### FeraLab ###" > $LOG
$B echo "" >> $LOG
$B echo "[$TIME] FeraDroid Engine v0.19" >> $LOG
$B echo "[$TIME] Firing up.." >> $LOG
$B echo "[$TIME] Device: $(getprop ro.product.brand) $(getprop ro.product.model)" >> $LOG
$B echo "[$TIME] Android version: $(getprop ro.build.version.release)" >> $LOG
$B echo "[$TIME] Kernel: $KERNEL" >> $LOG
$B echo "[$TIME] ROM version: $ROM" >> $LOG
$B echo "[$TIME] SDK: $SDK" >> $LOG

if [ -e /system/engine/prop/firstboot ]; then
 $B echo "[$TIME] First boot after deploy" >> $LOG
 $B mount -o remount,rw /system
 if [ -e /sbin/sysrw ]; then
  $B echo "[$TIME] Remapped partition mount detected" >> $LOG
  /sbin/sysrw
  $B sleep 1
 fi;
 $B echo "[$TIME] Setting permissions.. Installing Busybox.." >> $LOG
 chmod 777 /system/engine
 chmod -R 777 /system/engine/*
 chmod -R 777 /system/engine/assets/*
 chmod -R 777 /system/engine/bin/*
 chmod -R 777 /system/engine/gears/*
 chmod -R 777 /system/engine/prop/*
 $B chmod 644 /system/build.prop
 $B cp /system/engine/bin/zipalign /system/xbin/zipalign
 $B cp /system/engine/bin/boost /system/xbin/boost
 $B rm -f /system/engine/prop/firstboot
 if [ -e /system/engine/prop/ferakernel ]; then
  $B echo "[$TIME] FeraKernel detected" >> $LOG
 elif [ -e /system/etc/init.d/fde ]; then
  $B echo "[$TIME] FDE init.d init detected" >> $LOG
 else 
  $B echo "[$TIME] Flush init.d scripts (if any) to be safe" >> $LOG
  $B rm -Rf /system/etc/init.d
 fi;
 $B echo "[$TIME] Install Busybox.." >> $LOG
 $B --install -s /system/xbin
fi;
if [ -e /sbin/sysrw ]; then
 $B echo "[$TIME] Remapped partition mount detected" >> $LOG
 /sbin/sysrw
 $B sleep 1
fi;
$B echo "[$TIME] Remounting /data and /system - RW" >> $LOG
$B mount -o remount,rw /system
$B mount -o remount,rw /data
$B echo "[$TIME] Set SElinux permissive.." >> $LOG
$B chmod 666 /sys/fs/selinux/enforce
setenforce 0
$B echo 0 > /sys/fs/selinux/enforce
$B chmod 444 /sys/fs/selinux/enforce
$B echo "[$TIME] Correcting permissions.." >> $LOG
$B chmod 644 /system/build.prop
$B chmod 777 /system/engine
$B chmod 777 /cache
$B chmod -R 777 /cache/*
$B chmod -R 777 /system/engine/*
$B chmod -R 777 /system/engine/assets/*
$B chmod -R 777 /system/engine/gears/*
$B chmod -R 777 /system/engine/prop/*
$B echo "[$TIME] SYNC. Remount - RW." >> $LOG
sync;
$B mount -o remount,rw /system
$B rm -f /system/etc/sysctl.conf
$B touch /system/etc/sysctl.conf
$B chmod 777 /system/etc/sysctl.conf
$B echo "[$TIME] Running 001 gear.." >> $LOG
$SH /system/engine/gears/001abc.sh
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] Running 002 gear.." >> $LOG
$SH /system/engine/gears/002def.sh
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] Running 003 gear.." >> $LOG
$SH /system/engine/gears/003ghi.sh
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] Running 004 gear.." >> $LOG
TIME=$($B date | $B awk '{ print $4 }')
$SH /system/engine/gears/004jkl.sh
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] Running 005 gear.." >> $LOG
TIME=$($B date | $B awk '{ print $4 }')
$SH /system/engine/gears/005mno.sh
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] Running 006 gear.." >> $LOG
$SH /system/engine/gears/006pqr.sh
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] Running 007 gear.." >> $LOG
$SH /system/engine/gears/007stu.sh
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] Running 008 gear.." >> $LOG
$SH /system/engine/gears/008vwx.sh
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] Running 009 gear.." >> $LOG
$SH /system/engine/gears/009yza.sh
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] Running 010 gear.." >> $LOG
$SH /system/engine/gears/010bcd.sh
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] Fix permissions and zipalign.." >> $LOG
$SH /system/engine/fix.sh
if [ -e /system/etc/init.d/fde ]; then
 $B echo "[$TIME] Don't run init.d scripts.." >> $LOG
else
 $B echo "[$TIME] Run init.d scripts.." >> $LOG
 $B chmod 777 /system/etc/init.d/*
 $B run-parts /system/etc/init.d
fi;
TIME=$($B date | $B awk '{ print $4 }')
$B echo "" >> $LOG
$B echo "[$TIME] Applying kernel configuration.." >> $LOG
sysctl -p /system/etc/sysctl.conf | $B tee -a $LOG
$B echo "" >> $LOG
$B echo "[$TIME] BP dump" >> $LOG
getprop  | $B tee -a $LOG
$B echo "" >> $LOG
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] FDE status - OK" >> $LOG
$B echo "" >> $LOG
$B echo "[$TIME] GP services fix" >> $LOG
$B sleep 1
$B killall -9 com.google.android.gms
$B killall -9 com.google.android.gms.persistent
$B killall -9 com.google.process.gapps
$B killall -9 com.google.android.gsf
$B killall -9 com.google.android.gsf.persistent
$SH /system/engine/gp.sh
$B echo "[$TIME] Mediaserver kill" >> $LOG
$B sleep 9
$B killall -9 android.process.media
$B killall -9 mediaserver
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] Remounting /data and /system - RO" >> $LOG
$B mount -o remount,ro /system
$B echo "[$TIME] Sleep, sync and free RAM" >> $LOG
$B sleep 18
sync;
$B sleep 1
$B echo 3 > /proc/sys/vm/drop_caches
$B sleep 1
sync;
$B sleep 1
$B echo 2 > /proc/sys/vm/drop_caches
$B sleep 1
sync;
$B sleep 1
$B echo 1 > /proc/sys/vm/drop_caches
$B sleep 1
sync;
$B sleep 1
$B echo 3 > /proc/sys/vm/drop_caches
$B sleep 3
sync;
$B free -m | $B tee -a $LOG
$B echo "" >> $LOG

