#!/system/bin/sh
### FeraDroid Engine v0.23 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox
TIME=$($B date | $B awk '{ print $4 }')
RAM=$($B free -m | $B awk '{ print $2 }' | $B sed -n 2p)
$B echo "[$TIME] ***VM gear***"
$B echo "Tuning LMK.."
if [ -e /sys/module/lowmemorykiller/parameters/cost ]; then
 $B echo "LMK cost fine-tuning.."
 $B chmod 666 /sys/module/lowmemorykiller/parameters/cost
 $B chown 0:0 /sys/module/lowmemorykiller/parameters/cost
 $B echo "32" > /sys/module/lowmemorykiller/parameters/cost
fi;
if [ -e /sys/module/lowmemorykiller/parameters/fudgeswap ]; then
 $B echo "FudgeSwap support detected. Tuning.."
 $B chmod 666 /sys/module/lowmemorykiller/parameters/fudgeswap
 $B chown 0:0 /sys/module/lowmemorykiller/parameters/fudgeswap
 $B echo "1024" > /sys/module/lowmemorykiller/parameters/fudgeswap
fi;
if [ -e /sys/module/lowmemorykiller/parameters/debug_level ]; then
 $B chmod 666 /sys/module/lowmemorykiller/parameters/debug_level
 $B chown 0:0 /sys/module/lowmemorykiller/parameters/debug_level
 $B echo "0" > /sys/module/lowmemorykiller/parameters/debug_level
 $B echo "LMK debugging disabled"
fi;
if [ -e /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk ]; then
 $B chmod 666 /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
 $B chown 0:0 /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
 $B echo "0" > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
 $B echo "Disabled adaptive LMK."
fi;
$B chmod 666 /sys/module/lowmemorykiller/parameters/minfree
$B chown root /sys/module/lowmemorykiller/parameters/minfree
$B echo '2439,4878,7317,9756,17073,21951' > /sys/module/lowmemorykiller/parameters/minfree
setprop ro.HOME_APP_MEM 2048
setprop ro.HOME_APP_ADJ 0
setprop MIN_HIDDEN_APPS false
setprop MIN_RECENT_TASKS false
setprop APP_SWITCH_DELAY_TIME false
setprop MIN_CRASH_INTERVAL false
setprop dalvik.vm.checkjni false
setprop dalvik.vm.check-dex-sum false
setprop dalvik.vm.debug.alloc 0
setprop dalvik.vm.deadlock-predict off
setprop libc.debug.malloc 0
setprop persist.sys.purgeable_assets 1
setprop persist.added_boot_bgservices 2
setprop ro.config.max_starting_bg 3
setprop lmk.autocalc false
if [ "$RAM" -le "512" ]; then
 setprop ro.config.low_ram true
 setprop ro.sys.fw.bg_apps_limit 6
 setprop config.disable_atlas true
 $B echo "LOW RAM tweak.."
fi;
$B echo "[$TIME] ***VM gear*** - OK"
sync;
