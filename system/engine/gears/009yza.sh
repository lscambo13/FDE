#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###

B=/system/engine/bin/busybox
LOG=/sdcard/Android/FDE.txt
TIME=$($B date | $B awk '{ print $4 }')

$B echo "[$TIME] 009 - ***VM gear***" >> $LOG
$B echo "" >> $LOG
setprop MAX_SERVICE_INACTIVITY false
setprop MIN_HIDDEN_APPS false
setprop CONTENT_APP_IDLE_OFFSET false
setprop EMPTY_APP_IDLE_OFFSET false
setprop ACTIVITY_INACTIVE_RESET_TIME false
setprop MIN_RECENT_TASKS false
setprop APP_SWITCH_DELAY_TIME false
setprop PROC_START_TIMEOUT false
setprop CPU_MIN_CHECK_DURATION false
setprop GC_TIMEOUT false
setprop SERVICE_TIMEOUT false
setprop MIN_CRASH_INTERVAL false

if [ -e /system/xbin/sqlite3 ]; then
$B echo " Optimizing DataBases.." >> $LOG
for i in \
$($B find /data -iname "*.db") 
do \
 /system/xbin/sqlite3 "$i" 'VACUUM;'
 /system/xbin/sqlite3 "$i" 'REINDEX;'
done;
for i in \
$($B find /sdcard -iname "*.db")
do \
 /system/xbin/sqlite3 "$i" 'VACUUM;'
 /system/xbin/sqlite3 "$i" 'REINDEX;'
done;
fi;

$B echo "" >> $LOG
$B echo "[$TIME] 009 - ***VM gear*** - OK" >> $LOG
sync;

