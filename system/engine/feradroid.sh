#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox
SH=/system/engine/bin/sh

$B mount -o remount,rw /system
$B chmod -R 777 /system/engine/bin/*
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
$B chmod -R 777 /system/engine/bin/*
$B chmod -R 777 /system/engine/gears/*
$B chmod -R 777 /system/engine/prop/*
sync;
$B mount -o remount,rw /system
$SH /system/engine/gears/001abc.sh
$B mount -o remount,rw /system
$SH /system/engine/gears/002def.sh
$B mount -o remount,rw /system
$SH /system/engine/gears/003ghi.sh
$B mount -o remount,rw /system
$SH /system/engine/gears/004jkl.sh
$B mount -o remount,rw /system
$SH /system/engine/gears/005mno.sh
$B mount -o remount,rw /system
$SH /system/engine/gears/006pqr.sh
$B mount -o remount,rw /system
$SH /system/engine/gears/007stu.sh
$B mount -o remount,rw /system
$SH /system/engine/gears/008vwx.sh
$B mount -o remount,rw /system
$SH /system/engine/gears/009yza.sh
$B mount -o remount,ro /system
$B sleep 1
sync;

