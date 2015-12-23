#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox
SH=/system/engine/bin/sh

if [ -e /system/engine/prop/firstboot ]; then
 mount -o remount,rw /system
 chmod 777 /system/engine
 chmod -R 777 /system/engine/*
 chmod -R 777 /system/engine/assets/*
 chmod -R 777 /system/engine/bin/*
 chmod -R 777 /system/engine/gears/*
 chmod -R 777 /system/engine/prop/*
 $B chmod 644 /system/build.prop
 $B sleep 1
 $B mount -o remount,rw /system
 $B rm -f /system/engine/prop/firstboot
 $B --install -s /system/xbin
fi;
mount -o remount,rw /system
chmod -R 777 /system/engine/bin/*
setprop ro.feralab.engine 19
$B mount -o remount,rw /system
$B mount -o remount,rw /data
if [ -e /sbin/sysrw ]; then
 /sbin/sysrw
 $B sleep 1
fi;
$B chmod 644 /system/build.prop
$B chmod 777 /system/engine
$B chmod 777 /cache
$B chmod -R 777 /cache/*
$B chmod -R 777 /system/engine/*
$B chmod -R 777 /system/engine/assets/*
$B chmod -R 777 /system/engine/gears/*
$B chmod -R 777 /system/engine/prop/*
$B rm -f /system/etc/sysctl.conf
$B touch /system/etc/sysctl.conf
$B chmod 777 /system/etc/sysctl.conf
sync;
$B mount -o remount,rw /system
$SH /system/engine/gears/001abc.sh
$SH /system/engine/gears/002def.sh
$SH /system/engine/gears/003ghi.sh
$SH /system/engine/gears/004jkl.sh
$SH /system/engine/gears/005mno.sh
$SH /system/engine/gears/006pqr.sh
$SH /system/engine/gears/007stu.sh
$SH /system/engine/gears/008vwx.sh
$SH /system/engine/gears/009yza.sh
$SH /system/engine/gears/010bcd.sh
$B mount -o remount,ro /system
sysctl -p /system/etc/sysctl.conf
$B sleep 1
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

