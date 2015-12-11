#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox

$B echo "***Cleaning gear***"
$B echo " "
$B echo " "
$B mount -o remount,rw /system
$B mount -o remount,rw /data
$B rm -f /cache/*.apk
$B rm -f /cache/*.tmp
$B rm -f /cache/recovery/*.tmp
$B rm -f /data/*.log
$B rm -Rf /data/anr/*
$B rm -f /data/cache/*
$B rm -Rf /data/local/tmp/*
$B rm -f /data/local/*.apk
$B rm -f /data/local/*.log
$B rm -f /data/tombstones/*
$B rm -Rf /data/system/dropbox/*
$B rm -Rf /data/system/usagestats/*
$B rm -f /data/dalvik-cache/*.apk
$B rm -f /data/dalvik-cache/*.tmp
$B chmod 000 /data/tombstones
$B rm -Rf /system/lost+found/*
$B rm -Rf /mnt/sdcard/LOST.DIR/*
$B rm -Rf /mnt/sdcard/found000/*
$B rm -Rf /mnt/sdcard/LazyList/*
$B rm -Rf /mnt/sdcard/cleanmaster/*
$B rm -Rf /mnt/sdcard/albumthumbs/*
$B rm -Rf /mnt/sdcard/kunlun/*
$B rm -Rf /mnt/sdcard/.antutu/*
$B rm -Rf /mnt/sdcard/.estrongs/*
$B rm -Rf /mnt/sdcard/.kate/*
$B rm -Rf /mnt/sdcard/baidu/*
$B rm -Rf /mnt/sdcard/DCIM/.thumbnails/*
$B rm -f /mnt/sdcard/fix_permissions.log
$B echo " "
$B echo " "
$B echo "***Check***"
$B sleep 1
sync;

