#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox
SH=/system/engine/bin/sh

$B mount -o remount,rw /system
$B mount -o remount,rw /data
$B chmod 644 /system/build.prop
$B chmod -R 777 /system/engine/gears/*

if [ -e /system/etc/sysctl.conf ]; then
 $B chmod 777 /system/etc/sysctl.conf
 $B sysctl -p
else
 $B touch /system/etc/sysctl.conf
 $B chmod 777 /system/etc/sysctl.conf
fi;
sync;

if [ ! -h /data/local/tmp/adreno_config.txt ]; then
 $B chmod 777 /system/engine/assets/adreno_config.txt
 $B ln -s /system/engine/assets/adreno_config.txt /data/local/tmp/adreno_config.txt
fi;

$SH /system/engine/gears/001abc.sh
$SH /system/engine/gears/002def.sh
$SH /system/engine/gears/003ghi.sh
$SH /system/engine/gears/004jkl.sh
