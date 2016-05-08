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
 $B echo "32" > /sys/module/lowmemorykiller/parameters/cost
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
m1=$((RAM*2*1024/100/4))
m2=$((RAM*3*1024/100/4))
m3=$((RAM*6*1024/100/4))
m4=$((RAM*9*1024/100/4))
m5=$((RAM*12*1024/100/4))
m6=$((RAM*18*1024/100/4))
$B chmod 0664 /sys/module/lowmemorykiller/parameters/minfree
$B echo "$m1,$m2,$m3,$m4,$m5,$m6" > /sys/module/lowmemorykiller/parameters/minfree
$B echo "2048,3072,4096,6144,14336,18432" > /sys/module/lowmemorykiller/parameters/minfree
setprop ro.FOREGROUND_APP_MEM $m1
setprop ro.VISIBLE_APP_MEM $m2
setprop ro.PERCEPTIBLE_APP_MEM $m3
setprop ro.HEAVY_WEIGHT_APP_MEM $m3
setprop ro.SECONDARY_SERVER_MEM $m4
setprop ro.BACKUP_APP_MEM $m4
setprop ro.HOME_APP_MEM 2048
setprop ro.HIDDEN_APP_MEM $m5
setprop ro.EMPTY_APP_MEM $m6
$B echo "RAM tweak activated"
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
setprop dalvik.vm.jit.codecachesize 0
setprop persist.sys.purgeable_assets 1
$B echo "[$TIME] 009 - ***VM gear*** - OK"
sync;
