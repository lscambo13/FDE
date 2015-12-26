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
#$B echo -9 > /proc/$(pgrep rngd)/oom_adj
$B echo "" >> $LOG
$B echo "[$TIME] 009 - ***VM gear*** - OK" >> $LOG
sync;

