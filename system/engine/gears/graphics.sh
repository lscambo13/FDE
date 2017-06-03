#!/system/bin/sh
### FeraDroid Engine v1.1 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox;
SDK=$(getprop ro.build.version.sdk);
CORES=$($B grep -c 'processor' /proc/cpuinfo);
MADMAX=$($B cat /system/engine/raw/FDE_config.txt | $B grep -e 'mad_max=1');
if [ -e /sys/kernel/debug/msm_fb/0/vsync_enable ]; then
 $B echo "Disabling FPS-cap and tuning FB..";
 $B echo "0" > /sys/kernel/debug/msm_fb/0/vsync_enable;
 $B echo "16" > /sys/kernel/debug/msm_fb/mdp/mdp_usec_diff_treshold;
 $B echo "30" > /sys/kernel/debug/msm_fb/mdp/vs_rdcnt_slow;
fi;
if [ -e /dev/kgsl-3d0 ]; then
 $B echo "Setting correct KGSL permissions..";
 $B chmod 666 /dev/kgsl-3d0;
 $B chmod 666 /dev/genlock;
fi;
if [ -e /sys/devices/platform/kgsl/msm_kgsl/kgsl-3d0/io_fraction ]; then
 $B echo "Adreno i/o fraction tune-up..";
 $B echo "50" > /sys/devices/platform/kgsl/msm_kgsl/kgsl-3d0/io_fraction;
fi;
if [ -e /sys/class/kgsl/kgsl-3d0/max_pwrlevel ]; then
 $B echo "Adreno GPU freq. tune-up..";
 $B echo "0" > /sys/class/kgsl/kgsl-3d0/max_pwrlevel;
 $B echo "5" > /sys/class/kgsl/kgsl-3d0/default_pwrlevel;
fi;
if [ -e /sys/module/mali/parameters/mali_debug_level ]; then
 $B echo "Mali debugging disabled.";
 $B chown 0:0 /sys/module/mali/parameters/mali_debug_level;
 $B chmod 644 /sys/module/mali/parameters/mali_debug_level;
 $B echo "0" > /sys/module/mali/parameters/mali_debug_level;
fi;
if [ -e /sys/module/mali/parameters/mali_gpu_utilization_timeout ]; then
 $B echo "Mali util-timiout tuned.";
 $B chown 0:0 /sys/module/mali/parameters/mali_gpu_utilization_timeout;
 $B chmod 644 /sys/module/mali/parameters/mali_gpu_utilization_timeout;
 $B echo "100" > /sys/module/mali/parameters/mali_gpu_utilization_timeout;
fi;
if [ -e /sys/module/mali/parameters/mali_touch_boost_level ]; then
 $B echo "Mali touch-boost tuned.";
 $B chown 0:0 /sys/module/mali/parameters/mali_touch_boost_level;
 $B chmod 644 /sys/module/mali/parameters/mali_touch_boost_level;
 $B echo "1" > /sys/module/mali/parameters/mali_touch_boost_level;
fi;
if [ -e /sys/module/mali/parameters/mali_l2_max_reads ]; then
 $B echo "Mali L2 cache tuned.";
 $B chown 0:0 /sys/module/mali/parameters/mali_l2_max_reads;
 $B chmod 644 /sys/module/mali/parameters/mali_l2_max_reads;
 $B echo "0x00000030" > /sys/module/mali/parameters/mali_l2_max_reads;
fi;
if [ -e /sys/module/mali/parameters/mali_pp_scheduler_balance_jobs ]; then
 $B echo "Mali PP tuned.";
 $B chown 0:0 /sys/module/mali/parameters/mali_pp_scheduler_balance_jobs;
 $B chmod 644 /sys/module/mali/parameters/mali_pp_scheduler_balance_jobs;
 $B echo "1" > /sys/module/mali/parameters/mali_pp_scheduler_balance_jobs;
fi;
if [ -e /sys/module/mali/parameters/mali_max_pp_cores_group_1 ]; then
 $B echo "Mali PP group 1 tuned.";
 $B chown 0:0 /sys/module/mali/parameters/mali_max_pp_cores_group_1;
 $B chmod 644 /sys/module/mali/parameters/mali_max_pp_cores_group_1;
 $B echo "2" > /sys/module/mali/parameters/mali_max_pp_cores_group_1;
fi;
if [ -e /sys/module/mali/parameters/mali_max_pp_cores_group_2 ]; then
 $B echo "Mali PP group 2 tuned.";
 $B chown 0:0 /sys/module/mali/parameters/mali_max_pp_cores_group_2;
 $B chmod 644 /sys/module/mali/parameters/mali_max_pp_cores_group_2;
 $B echo "2" > /sys/module/mali/parameters/mali_max_pp_cores_group_2;
fi;
if [ -e /init.scx15.rc ]; then
 $B echo "Boosting ARK Benefit M2C Mali GPU - locking to 312Mhz..";
 $B chown 0:0 /sys/module/mali/parameters/gpu_cur_freq;
 $B chmod 644 /sys/module/mali/parameters/gpu_cur_freq;
 $B echo "312000" > /sys/module/mali/parameters/gpu_cur_freq;
 $B chmod 444 /sys/module/mali/parameters/gpu_cur_freq;
fi;
if [ -e /sys/devices/14ac0000.mali/dvfs ]; then
 $B echo "Disabling Mali DVFS..";
 $B chmod 000 /sys/devices/14ac0000.mali/dvfs;
 $B chmod 000 /sys/devices/14ac0000.mali/dvfs_max_lock;
 $B chmod 000 /sys/devices/14ac0000.mali/dvfs_min_lock;
fi;
if [ -e /sys/module/tpd_setting/parameters/tpd_mode ]; then
 $B chmod 644 /sys/module/tpd_setting/parameters/tpd_mode;
 $B echo "1" > /sys/module/tpd_setting/parameters/tpd_mode;
 $B echo "TPD tune-up..";
fi;
if [ -e /sys/module/hid_magicmouse/parameters/scroll_speed ]; then
 $B chmod 644 /sys/module/hid_magicmouse/parameters/scroll_speed;
 $B echo "63" > /sys/module/hid_magicmouse/parameters/scroll_speed;
 $B echo "HID-magic tune-up..";
fi;
if [ -e /sys/devices/virtual/sec/sec_touchscreen/tsp_threshold ]; then
 $B echo "50" > /sys/devices/virtual/sec/sec_touchscreen/tsp_threshold;
 $B echo "Touchscreen sensivity tune-up..";
fi;
if [ -e /sys/class/touch/switch/set_touchscreen ]; then
 $B echo "7035" > /sys/class/touch/switch/set_touchscreen;
 $B echo "8002" > /sys/class/touch/switch/set_touchscreen;
 $B echo "11000" > /sys/class/touch/switch/set_touchscreen;
 $B echo "13060" > /sys/class/touch/switch/set_touchscreen;
 $B echo "14005" > /sys/class/touch/switch/set_touchscreen;
 $B echo "Touchscreen sensivity tune-up..";
fi;
if [ "mad_max=1" = "$MADMAX" ]; then
 $B echo "Mad GPU.";
 $B echo "Forcing HW rendering..";
 setprop debug.sf.hw 1;
 setprop debug.egl.hw 1;
 setprop debug.gr.swapinterval 1;
 setprop debug.gr.numframebuffers 3;
 setprop persist.sys.scrollingcache 3;
 setprop persist.sys.ui.hw 1;
 setprop video.accelerate.hw 1;
 setprop ro.config.disable.hw_accel false;
fi;
if [ "$SDK" -le "21" ]; then
 $B echo "Bypassing stagerfright security vulnerabilities..";
 setprop media.stagefright.enable-http false;
 setprop media.stagefright.enable-qcp false;
 setprop media.stagefright.enable-fma2dp false;
 setprop media.stagefright.enable-scan false;
fi;
sync;
$B sleep 1
