#!/system/bin/sh
### FeraDroid Engine v0.21 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
TIME=$($B date | $B awk '{ print $4 }')
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p)
$B echo "[$TIME] ***VM gear***"
$B echo "Tuning LMK.."
if [ -e /sys/module/lowmemorykiller/parameters/cost ]; then
 $B echo "LMK cost fine-tuning.."
 $B chown 0:0 /sys/module/lowmemorykiller/parameters/cost
 $B chmod 644 /sys/module/lowmemorykiller/parameters/cost
 $B echo "16" > /sys/module/lowmemorykiller/parameters/cost
fi;
if [ -e /sys/module/lowmemorykiller/parameters/fudgeswap ]; then
 $B echo "FudgeSwap support detected. Tuning.."
 $B chown 0:0 /sys/module/lowmemorykiller/parameters/fudgeswap
 $B chmod 644 /sys/module/lowmemorykiller/parameters/fudgeswap
 $B echo "1024" > /sys/module/lowmemorykiller/parameters/fudgeswap
fi;
if [ -e /sys/module/lowmemorykiller/parameters/debug_level ]; then
 $B chown 0:0 /sys/module/lowmemorykiller/parameters/debug_level
 $B echo "0" > /sys/module/lowmemorykiller/parameters/debug_level
 $B echo "LMK debugging disabled"
fi;
if [ -e /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk ]; then
 $B chown 0:0 /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
 $B echo "0" > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
 setprop lmk.autocalc false
 $B echo "Disabled adaptive LMK."
else
 setprop lmk.autocalc false
fi;
if [ "$RAM" -le "512" ]; then
 setprop ro.config.low_ram true
 setprop ro.sys.fw.bg_apps_limit 6
 setprop persist.added_boot_bgservices 2
 setprop config.disable_atlas true
 setprop ro.config.max_starting_bg 3
 $B echo "LOW RAM tweak.."
fi;
setprop ro.HOME_APP_MEM 2048
setprop ro.HOME_APP_ADJ 0
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
setprop dalvik.vm.debug.alloc 0
setprop dalvik.vm.deadlock-predict off
setprop dalvik.vm.jit.codecachesize 0
setprop libc.debug.malloc 0
setprop persist.sys.purgeable_assets 1
$B echo "[$TIME] ***VM gear*** - OK"
sync;
