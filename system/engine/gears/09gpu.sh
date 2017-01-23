#!/system/bin/sh
### FeraDroid Engine v0.23 | By FeraVolt. 2017 ###
B=/system/engine/bin/busybox
TIME=$($B date | $B awk '{ print $4 }')
SDK=$(getprop ro.build.version.sdk)
CORES=$($B grep -c 'processor' /proc/cpuinfo)
$B echo "[$TIME] ***GPU gear***"
$B echo "Remounting /system - RW"
$B mount -o remount,rw /system
$B mount -t debugfs debugfs /sys/kernel/debug
if [ -e /system/lib/egl/libGLESv2_adreno200.so ]; then
 $B echo "Adreno GPU detected"
 if [ "$SDK" -eq "10" ]; then
  if [ -e /init.es209ra.rc ]; then
   if [ -e /system/etc/adreno_config.txt ]; then
    $B rm -f /system/etc/adreno_config.txt
    $B rm -f /data/local/tmp/adreno_config.txt
   fi;
   $B echo "X10 adreno 'config'.."
  elif [ ! -h /data/local/tmp/adreno_config.txt ]; then
   $B echo "Applying Adreno configurations.."
   $B chmod 755 /system/engine/assets/adreno_config.txt
   $B ln -s /system/engine/assets/adreno_config.txt /data/local/tmp/adreno_config.txt
  fi;
 fi;
 $B echo "Setting correct device permissions.."
 $B chmod 666 /dev/kgsl-3d0
 $B chmod 666 /dev/msm_aac_in
 $B chmod 666 /dev/msm_amr_in
 $B chmod 666 /dev/genlock
 $B echo "Tuning Android and Adreno frienship.."
 setprop com.qc.hardware true
 setprop debug.qc.hardware true
 setprop debug.qctwa.statusbar 1
 setprop debug.qctwa.perservebuf 1
fi;
if [ "$SDK" -eq "10" ]; then
 if [ -e /system/lib/egl/libGLES_android.so ]; then
  if [ -e /system/lib/egl/libGLESv2_adreno200.so ]; then
   AV=$(du -k "/system/lib/egl/libGLESv2_adreno200.so" | cut -f1)
   if [ "$AV" -eq "1712" ]; then
    $B echo "You have legacy adreno libs. No HWA for you."
   else
    $B echo "Forcing GPU to render UI.."
    $B mount -o remount,rw /system
    $B sed -i '/0 0 android/d' /system/lib/egl/egl.cfg
    $B rm -f /system/lib/egl/libGLES_android.so
   fi;
  fi;
 fi;
fi;
if [ -e /sys/module/mali/parameters/mali_debug_level ]; then
 $B echo "Mali GPU detected. Tuning.."
 $B chown 0:0 /sys/module/mali/parameters/mali_debug_level
 $B chmod 644 /sys/module/mali/parameters/mali_debug_level
 $B echo 0 > /sys/module/mali/parameters/mali_debug_level
 if [ -e /sys/module/mali/parameters/mali_gpu_utilization_timeout ]; then
  $B echo "Mali util-timiout tuned."
  $B chown 0:0 /sys/module/mali/parameters/mali_gpu_utilization_timeout
  $B chmod 644 /sys/module/mali/parameters/mali_gpu_utilization_timeout
  $B echo 100 > /sys/module/mali/parameters/mali_gpu_utilization_timeout
 fi;
 if [ -e /sys/module/mali/parameters/mali_touch_boost_level ]; then
  $B echo "Mali touch-boost tuned."
  $B chown 0:0 /sys/module/mali/parameters/mali_touch_boost_level
  $B chmod 644 /sys/module/mali/parameters/mali_touch_boost_level
  $B echo 1 > /sys/module/mali/parameters/mali_touch_boost_level
 fi;
 if [ -e /sys/module/mali/parameters/mali_l2_max_reads ]; then
  $B echo "Mali L2 cache tuned."
  $B chown 0:0 /sys/module/mali/parameters/mali_l2_max_reads
  $B chmod 644 /sys/module/mali/parameters/mali_l2_max_reads
  $B echo 0x00000030 > /sys/module/mali/parameters/mali_l2_max_reads
 fi;
 if [ -e /sys/module/mali/parameters/mali_pp_scheduler_balance_jobs ]; then
  $B echo "Mali PP tuned."
  $B chown 0:0 /sys/module/mali/parameters/mali_pp_scheduler_balance_jobs
  $B chmod 644 /sys/module/mali/parameters/mali_pp_scheduler_balance_jobs
  $B echo 1 > /sys/module/mali/parameters/mali_pp_scheduler_balance_jobs
 fi;
 if [ -e /sys/module/mali/parameters/mali_max_pp_cores_group_1 ]; then
  $B echo "Mali PP group 1 tuned."
  $B chown 0:0 /sys/module/mali/parameters/mali_max_pp_cores_group_1
  $B chmod 644 /sys/module/mali/parameters/mali_max_pp_cores_group_1
  $B echo 2 > /sys/module/mali/parameters/mali_max_pp_cores_group_1
 fi;
 if [ -e /sys/module/mali/parameters/mali_max_pp_cores_group_2 ]; then
  $B echo "Mali PP group 2 tuned."
  $B chown 0:0 /sys/module/mali/parameters/mali_max_pp_cores_group_2
  $B chmod 644 /sys/module/mali/parameters/mali_max_pp_cores_group_2
  $B echo 2 > /sys/module/mali/parameters/mali_max_pp_cores_group_2
 fi;
 if [ -e /init.scx15.rc ]; then
  $B echo "Boosting ARK Benefit M2C Mali GPU - locking to 312Mhz.."
  $B chown 0:0 /sys/module/mali/parameters/gpu_cur_freq
  $B chmod 644 /sys/module/mali/parameters/gpu_cur_freq
  $B echo 312000 > /sys/module/mali/parameters/gpu_cur_freq
  $B chmod 444 /sys/module/mali/parameters/gpu_cur_freq
 fi;
fi;
$B mount -t debugfs debugfs /sys/kernel/debug
$B chmod 777 /dev/graphics/fb0
if [ -e /sys/kernel/debug/msm_fb/0/vsync_enable ]; then
 $B echo "Disabling VSYNC.."
 $B echo 0 > /sys/kernel/debug/msm_fb/0/vsync_enable
fi;
if [ -e /sys/devices/platform/kgsl/msm_kgsl/kgsl-3d0/io_fraction ]; then
 $B echo 50 > /sys/devices/platform/kgsl/msm_kgsl/kgsl-3d0/io_fraction
 $B echo "KGSL tune-up.."
fi;
if [ -e /system/engine/prop/firstboot ]; then
 if [ -e /system/xbin/sqlite3 ]; then
  $B echo "Tuning Android animations.."
  $B echo "REPLACE INTO \"system\" VALUES(26,'window_animation_scale','0.25');REPLACE INTO \"system\" VALUES(27,'transition_animation_scale','0.25');" | sqlite3 /data/data/com.android.providers.settings/databases/settings.db
 fi;
 settings put system window_animation_scale 0.25
 settings put system transition_animation_scale 0.25
 settings put system animator_duration_scale 0.25
 content update --uri content://settings/system --bind value:s:0.25 --where 'name="window_animation_scale"'
 content update --uri content://settings/system --bind value:s:0.25 --where 'name="transition_animation_scale"'
 content update --uri content://settings/system --bind value:s:0.25 --where 'name="animator_duration_scale"'
fi;
if [ -e /sys/module/tpd_setting/parameters/tpd_mode ]; then
 $B chmod 644 /sys/module/tpd_setting/parameters/tpd_mode
 $B echo 1 > /sys/module/tpd_setting/parameters/tpd_mode
 $B echo "TPD tune-up.."
fi;
if [ -e /sys/module/hid_magicmouse/parameters/scroll_speed ]; then
 $B chmod 644 /sys/module/hid_magicmouse/parameters/scroll_speed
 $B echo 63 > /sys/module/hid_magicmouse/parameters/scroll_speed
 $B echo "HID-magic tune-up"
fi;
if [ -e /sys/devices/virtual/sec/sec_touchscreen/tsp_threshold ]; then
 $B echo "50" > /sys/devices/virtual/sec/sec_touchscreen/tsp_threshold
 $B echo "Touchscreen sensivity tune-up"
fi;
if [ -e /sys/class/touch/switch/set_touchscreen ]; then
 $B echo 7035 > /sys/class/touch/switch/set_touchscreen
 $B echo 8002 > /sys/class/touch/switch/set_touchscreen
 $B echo 11000 > /sys/class/touch/switch/set_touchscreen
 $B echo 13060 > /sys/class/touch/switch/set_touchscreen
 $B echo 14005 > /sys/class/touch/switch/set_touchscreen
 $B echo "Touchscreen sensivity tune-up [2]"
fi;
$B echo "Tuning Android graphics.."
if [ "$SDK" -le "19" ]; then
 $B echo "Butter.."
 setprop debug.sf.hw 1
 setprop debug.egl.hw 1
 setprop debug.gr.swapinterval 1
 setprop debug.gr.numframebuffers 3
 setprop persist.sys.scrollingcache 3
fi;
setprop persist.sys.ui.hw 1
setprop video.accelerate.hw 1
setprop hwui.render_dirty_regions false
setprop debug.hwui.render_dirty_regions false
setprop ro.config.disable.hw_accel false
setprop ro.media.dec.jpeg.memcap 8000000
setprop ro.media.enc.hprof.vid.bps 8000000
setprop ro.media.enc.jpeg.quality 100
setprop ro.floatingtouch.available 1
setprop persist.sys.strictmode.disable true
setprop vidc.debug.level 0
setprop ro.camera.sound.forced 0
if [ "$SDK" -le "21" ]; then
$B echo "Fix stagerfright security vulnerabilities.."
 setprop media.stagefright.enable-player false
 setprop media.stagefright.enable-http false
 setprop media.stagefright.enable-aac false
 setprop media.stagefright.enable-qcp false
 setprop media.stagefright.enable-fma2dp false
 setprop media.stagefright.enable-scan false
fi;
if [ "$CORES" -ge "5" ] ; then
 $B echo "Dithering - ON"
 setprop persist.sys.use_dithering 1
else
 $B echo "Dithering - OFF"
 setprop persist.sys.use_dithering 0
fi;
if [ -e /system/engine/prop/firstboot ]; then
 if [ "$SDK" -ge "21" ] ; then
  $B mount -o remount,rw /system
  setprop persist.bt.a2dp_offload_cap sbc-aptx-aptxhd
  $B cp -f /system/engine/assets/libaptX.so /system/vendor/lib/libaptX.so
  $B cp -f /system/engine/assets/libaptXHD.so /system/vendor/lib/libaptXHD.so
  $B cp -f /system/engine/assets/libaptXScheduler.so /system/vendor/lib/libaptXScheduler.so
  $B chmod 644 /system/vendor/lib/*
  $B echo "BT aptxHD codec activated"
 fi;
fi;
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] ***GPU gear*** - OK"
sync;
