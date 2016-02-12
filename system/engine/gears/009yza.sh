#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
LOG=/sdcard/Android/FDE.txt
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] 009 - ***VM gear***" >> $LOG
$B echo "Tuning LMK.." >> $LOG
if [ -e /sys/module/lowmemorykiller/parameters/cost ]; then
 $B echo "LMK cost fine-tuning.." >> $LOG
 $B chmod 644 /sys/module/lowmemorykiller/parameters/cost
 $B echo "16" > /sys/module/lowmemorykiller/parameters/cost
fi;
if [ -e /sys/module/lowmemorykiller/parameters/fudgeswap ]; then
 $B echo "FudgeSwap supported. Tuning.." >> $LOG
 $B chmod 644 /sys/module/lowmemorykiller/parameters/fudgeswap
 $B echo "1024" > /sys/module/lowmemorykiller/parameters/fudgeswap
fi;
if [ -e /sys/module/lowmemorykiller/parameters/debug_level ]; then
 $B echo "0" > /sys/module/lowmemorykiller/parameters/debug_level
 $B echo "LMK debugging disabled" >> $LOG
fi;
if [ -e /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk ]; then
 $B echo "1" > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
 $B echo "40960" > /sys/module/lowmemorykiller/parameters/vmpressure_file_min 40960
 setprop lmk.autocalc true
 $B echo "Adaptive LMK detected. Tuned." >> $LOG
else
 setprop lmk.autocalc false
fi;
$B echo "Tuning Android proc.." >> $LOG
setprop ro.HOME_APP_ADJ 1
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
setprop dalvik.vm.checkjni false
setprop dalvik.vm.dexopt-data-only 1
setprop persist.sys.purgeable_assets 1
$B echo "[$TIME] 009 - ***VM gear*** - OK" >> $LOG
sync;
