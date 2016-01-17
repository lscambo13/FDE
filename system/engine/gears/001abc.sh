#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###

B=/system/engine/bin/busybox
if [ -e /system/engine/prop/firstboot ]; then
 LOG=/sdcard/Android/FDE.txt
else
 LOG=/dev/null
fi;
TIME=$($B date | $B awk '{ print $4 }')

$B echo "[$TIME] 001 - ***Cleaning gear***" >> $LOG
$B echo "Remounting /data and /system - RW" >> $LOG
$B mount -o remount,rw /system
$B mount -o remount,rw /data
$B echo "Cleaning trash.." >> $LOG
$B rm -f /cache/*.apk
$B rm -f /cache/*.tmp
$B rm -f /cache/*.log
$B rm -f /cache/*.txt
$B rm -f /cache/recovery/*
$B rm -f /data/*.log
$B rm -f /data/*.txt
$B rm -f /data/anr/*.log
$B rm -f /data/anr/*.txt
$B rm -f /data/backup/pending/*.tmp
$B rm -f /data/cache/*.*
$B rm -f /data/data/*.log
$B rm -f /data/data/*.txt
$B rm -f /data/dalvik-cache/*.apk
$B rm -f /data/dalvik-cache/*.tmp
$B rm -f /data/log/*.log
$B rm -f /data/log/*.txt
$B rm -f /data/local/*.apk
$B rm -f /data/local/*.log
$B rm -f /data/local/*.txt
$B rm -f /data/local/tmp/*.log
$B rm -f /data/local/tmp/*.txt
$B rm -f /data/last_alog/*.log
$B rm -f /data/last_alog/*.txt
$B rm -f /data/last_kmsg/*.log
$B rm -f /data/last_kmsg/*.txt
$B rm -f /data/mlog/*
$B rm -f /data/tombstones/*.log
$B rm -f /data/tombstones/*.txt
$B rm -f /data/system/*.log
$B rm -f /data/system/*.txt
$B rm -f /data/system/dropbox/*.log
$B rm -f /data/system/dropbox/*.txt
$B rm -f /data/system/usagestats/*.log
$B rm -f /data/system/usagestats/*.txt
$B rm -Rf /mnt/sdcard/LOST.DIR
$B rm -Rf /mnt/sdcard/found000
$B rm -Rf /mnt/sdcard/LazyList
$B rm -Rf /mnt/sdcard/cleanmaster
$B rm -Rf /mnt/sdcard/albumthumbs
$B rm -Rf /mnt/sdcard/kunlun
$B rm -Rf /mnt/sdcard/.antutu
$B rm -Rf /mnt/sdcard/.estrongs
$B rm -Rf /mnt/sdcard/baidu
$B rm -f /mnt/sdcard/fix_permissions.log
$B chmod 000 /data/tombstones
$B sleep 1
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] 001 - ***Cleaning gear*** - OK" >> $LOG
sync;

