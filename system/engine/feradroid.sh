#!/system/bin/sh
### FeraDroid Engine v0.20 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
TIME=$($B date | $B awk '{ print $4 }')
KERNEL=$($B uname -r)
ARCH=$($B uname -m)
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p)
ROM=$(getprop ro.build.display.id)
SDK=$(getprop ro.build.version.sdk)
SF=$($B df -Ph /system | $B grep -v ^Filesystem | $B awk '{print $4}')
LOG=/sdcard/Android/FDE.txt
mount -o remount,rw /system
chmod 755 /system/engine/bin/*
setprop ro.feralab.engine 20
$B sleep 45
$B rm -f $LOG
$B touch $LOG
$B echo "### FeraLab ###" > $LOG
$B echo "" >> $LOG
$B echo "[$TIME] FeraDroid Engine v0.20-b3" >> $LOG
$B echo "[$TIME] Firing up.." >> $LOG
$B echo "[$TIME] Device: $(getprop ro.product.brand) $(getprop ro.product.model)" >> $LOG
$B echo "[$TIME] Architecture: $ARCH" >> $LOG
$B echo "[$TIME] RAM: $RAM MB" >> $LOG
$B echo "[$TIME] Kernel version: $KERNEL" >> $LOG
$B echo "[$TIME] ROM version: $ROM" >> $LOG
$B echo "[$TIME] Android version: $(getprop ro.build.version.release)" >> $LOG
$B echo "[$TIME] SDK: $SDK" >> $LOG
$B echo "[$TIME] /system free space: $SF" >> $LOG
if [ -e /system/engine/prop/firstboot ]; then
 $B echo "[$TIME] First boot after deploy" >> $LOG
 $B mount -o remount,rw /system
 if [ -e /sbin/sysrw ]; then
  /sbin/sysrw
  $B sleep 1
 fi;
 $B cp /system/engine/bin/zipalign /system/xbin/zipalign
 $B cp /system/engine/bin/boost /system/xbin/boost
fi;
if [ -e /sys/fs/selinux/enforce ]; then
 $B chmod 666 /sys/fs/selinux/enforce
 setenforce 0
 $B echo 0 > /sys/fs/selinux/enforce
 $B chmod 444 /sys/fs/selinux/enforce
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
$B echo "[$TIME] Correcting permissions.." >> $LOG
$B chmod 644 /system/build.prop
$B chmod -R 777 /cache/*
$B chmod -R 755 /system/engine/*
$B chmod 755 /system/engine/assets/*
$B chmod 755 /system/engine/gears/*
$B chmod 755 /system/engine/prop/*
sync;
$B mount -o remount,rw /system
$B rm -f /system/etc/sysctl.conf
$B touch /system/etc/sysctl.conf
$B chmod 755 /system/etc/sysctl.conf
if [ -e /system/engine/gears/001abc.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running 001 gear.." >> $LOG
 /system/engine/gears/001abc.sh
fi;
if [ -e /system/engine/gears/002def.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running 002 gear.." >> $LOG
 /system/engine/gears/002def.sh
fi;
if [ -e /system/engine/gears/003ghi.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running 003 gear.." >> $LOG
 /system/engine/gears/003ghi.sh
fi;
if [ -e /system/engine/gears/004jkl.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running 004 gear.." >> $LOG
 /system/engine/gears/004jkl.sh
fi;
if [ -e /system/engine/gears/005mno.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running 005 gear.." >> $LOG
 /system/engine/gears/005mno.sh
fi;
if [ -e /system/engine/gears/006pqr.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running 006 gear.." >> $LOG
 /system/engine/gears/006pqr.sh
fi;
if [ -e /system/engine/gears/007stu.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running 007 gear.." >> $LOG
 /system/engine/gears/007stu.sh
fi;
if [ -e /system/engine/gears/008vwx.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running 008 gear.." >> $LOG
 /system/engine/gears/008vwx.sh
fi;
if [ -e /system/engine/gears/009yza.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running 009 gear.." >> $LOG
 /system/engine/gears/009yza.sh
fi;
if [ -e /system/engine/gears/010bcd.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running 010 gear.." >> $LOG
 /system/engine/gears/010bcd.sh
fi;
if [ -e /system/engine/gears/011efg.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] Running 011 gear.." >> $LOG
 /system/engine/gears/011efg.sh
fi;
if [ -e /system/engine/end.sh ]; then
 TIME=$($B date | $B awk '{ print $4 }')
 $B echo "[$TIME] "END" start" >> $LOG
 /system/engine/end.sh
fi;
if [ -e /system/engine/prop/firstboot ]; then
 $B mount -o remount,rw /system
 $B rm -f /system/engine/prop/firstboot
 $B mount -o remount,ro /system
 $B echo "[$TIME] First boot completed." >> $LOG
fi;
$B echo "" >> $LOG
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] FDE status - OK" >> $LOG
$B echo "" >> $LOG
