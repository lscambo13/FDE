#!/system/bin/sh
### FeraDroid Engine v0.20 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
TIME=$($B date | $B awk '{ print $4 }')
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p)
$B echo "[$TIME] 009 - ***VM gear***"
$B echo "Tuning LMK.."
if [ -e /sys/module/lowmemorykiller/parameters/cost ]; then
 $B echo "LMK cost fine-tuning.."
 $B chmod 644 /sys/module/lowmemorykiller/parameters/cost
 $B echo "16" > /sys/module/lowmemorykiller/parameters/cost
fi;
if [ -e /sys/module/lowmemorykiller/parameters/fudgeswap ]; then
 $B echo "FudgeSwap supported. Tuning.."
 $B chmod 644 /sys/module/lowmemorykiller/parameters/fudgeswap
 $B echo "1024" > /sys/module/lowmemorykiller/parameters/fudgeswap
fi;
if [ -e /sys/module/lowmemorykiller/parameters/debug_level ]; then
 $B echo "0" > /sys/module/lowmemorykiller/parameters/debug_level
 $B echo "LMK debugging disabled"
fi;
if [ -e /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk ]; then
 $B echo "0" > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
 setprop lmk.autocalc false
 $B echo "Disabled adaptive LMK."
else
 setprop lmk.autocalc false
fi;
if [ "$RAM" -le "512" ]; then
 $B chmod 0664 /sys/module/lowmemorykiller/parameters/minfree
 $B echo "2048,3072,4096,6144,14336,18432" > /sys/module/lowmemorykiller/parameters/minfree
 setprop ro.FOREGROUND_APP_MEM 2048
 setprop ro.VISIBLE_APP_MEM 3072
 setprop ro.PERCEPTIBLE_APP_MEM 4096
 setprop ro.HEAVY_WEIGHT_APP_MEM 4096
 setprop ro.SECONDARY_SERVER_MEM 6144
 setprop ro.BACKUP_APP_MEM 6144
 setprop ro.HOME_APP_MEM 2048
 setprop ro.HIDDEN_APP_MEM 14336
 setprop ro.EMPTY_APP_MEM 18432
 $B echo "LOW RAM tweak activated"
fi;
$B echo "Tuning Android proc.."
$B chmod 0664 /sys/module/lowmemorykiller/parameters/adj
$B echo "0,1,2,4,7,15" /sys/module/lowmemorykiller/parameters/adj
setprop ro.FOREGROUND_APP_ADJ 0
setprop ro.VISIBLE_APP_ADJ 1
setprop ro.PERCEPTIBLE_APP_ADJ 2
setprop ro.HEAVY_WEIGHT_APP_ADJ 3
setprop ro.SECONDARY_SERVER_ADJ 4
setprop ro.BACKUP_APP_ADJ 5
setprop ro.HIDDEN_APP_MIN_ADJ 7
setprop ro.EMPTY_APP_ADJ 15
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
setprop dalvik.vm.check-dex-sum false
setprop dalvik.vm.verify-bytecode false
setprop dalvik.vm.gc.verifycardtable false
setprop dalvik.vm.gc.postverify false
setprop dalvik.vm.gc.preverify false
setprop dalvik.vm.debug.alloc 0
setprop dalvik.vm.deadlock-predict off
setprop persist.sys.purgeable_assets 1
$B echo "[$TIME] 009 - ***VM gear*** - OK"
sync;
