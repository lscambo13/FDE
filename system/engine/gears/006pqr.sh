#!/system/bin/sh
### FeraDroid Engine v0.21 | By FeraVolt. 2016 ###
B=/system/engine/bin/busybox
ARCH=$($B uname -m)
TIME=$($B date | $B awk '{ print $4 }')
SDK=$(getprop ro.build.version.sdk)
COM=$(getprop debug.composition.type)
$B echo "[$TIME] 006 - ***GPU gear***"
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
  if [ -e /system/lib/egl/egl.cfg ]; then
   if [ -e /system/lib/egl/libGLESv2_adreno200.so ]; then
    AV=$(du -k "/system/lib/egl/libGLESv2_adreno200.so" | cut -f1)
    if [ "$AV" -eq "1712" ]; then
     $B echo "You have legacy adreno libs. No HWA for you."
     exit
    fi;
   fi;
   $B echo "Forcing GPU to render UI.."
   $B mount -o remount,rw /system
   $B sed -i '/0 0 android/d' /system/lib/egl/egl.cfg
   $B rm /system/lib/egl/libGLES_android.so
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
if [ "$ARCH" == "armv6l" ]; then
 $B echo "No hard tuning for ARMv6.."
else
 $B echo "Tuning Android graphics.."
 setprop debug.sf.hw 1
 setprop debug.egl.hw 1
 setprop debug.egl.swapinterval 1
 setprop debug.gr.swapinterval 1
 setprop persist.hwc.mdpcomp.enable true
 setprop debug.mdpcomp.logs 0
 setprop debug.mdpcomp.maxlayer 3
 setprop debug.mdpcomp.idletime -1
 setprop debug.gr.numframebuffers 3
 setprop dev.pm.dyn_samplingrate 1
 setprop persist.sys.ui.hw 1
 setprop video.accelerate.hw 1
 setprop windowsmgr.max_events_per_sec 120
 setprop windowsmgr.support_rotation_270 true
 setprop hwui.render_dirty_regions false
 setprop debug.hwui.render_dirty_regions false
 setprop persist.sys.scrollingcache 3
 setprop ro.media.dec.jpeg.memcap 8000000
 setprop ro.media.enc.hprof.vid.bps 8000000
 setprop ro.media.enc.jpeg.quality 100
 setprop touch.presure.scale 1.0
 setprop ro.floatingtouch.available 1
 setprop ro.min.fling_velocity 9000
 setprop ro.max.fling_velocity 12000
 setprop persist.sys.strictmode.disable true
 setprop vidc.debug.level 0
 setprop ro.camera.sound.forced 0
 setprop persist.sys.use_dithering 0
 setprop ro.lge.proximity.delay 25
 setprop mot.proximity.delay 25
fi;
TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] 006 - ***GPU gear*** - OK"
sync;
