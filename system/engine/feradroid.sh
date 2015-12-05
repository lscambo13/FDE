#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox

$B mount -o remount,rw /system
$B mount -o remount,rw /data
$B chmod 644 /system/build.prop
$B chmod -R 777 /system/etc/sysctl.conf
$B rm -f /data/cache/*.apk
$B rm -f /data/cache/*.tmp
$B rm -f /data/dalvik-cache/*.apk
$B rm -f /data/dalvik-cache/*.tmp
$B rm -Rf /system/lost+found/*
$B rm -f /data/tombstones/*
$B rm -f /mnt/sdcard/LOST.DIR/*
$B rm -Rf /mnt/sdcard/LOST.DIR
$B rm -f /mnt/sdcard/found000/*
$B rm -Rf /mnt/sdcard/found000
$B rm -f /mnt/sdcard/fix_permissions.log
$B chmod 000 /data/tombstones
$B run-parts /system/engine/gears