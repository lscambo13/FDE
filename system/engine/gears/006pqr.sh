#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2015 ###

B=/system/engine/bin/busybox

if [ ! -h /data/local/tmp/adreno_config.txt ]; then
 $B chmod 777 /system/engine/assets/adreno_config.txt
 $B ln -s /system/engine/assets/adreno_config.txt /data/local/tmp/adreno_config.txt
fi;

$B mount -t debugfs debugfs /sys/kernel/debug
$B chmod 666 /dev/kgsl-3d0
$B chmod 666 /dev/msm_aac_in
$B chmod 666 /dev/msm_amr_in
$B chmod 666 /dev/genlock
$B chmod 777 /dev/graphics/fb0
$B echo 0 > /sys/kernel/debug/msm_fb/0/vsync_enable
$B echo 16 > /sys/kernel/debug/msm_fb/mdp/mdp_usec_diff_treshold
$B echo 30 > /sys/kernel/debug/msm_fb/mdp/vs_rdcnt_slow
sync;

