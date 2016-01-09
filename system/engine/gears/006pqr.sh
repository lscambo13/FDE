#!/system/bin/sh
### FeraDroid Engine v0.19 | By FeraVolt. 2016 ###

B=/system/engine/bin/busybox
LOG=/sdcard/Android/FDE.txt
TIME=$($B date | $B awk '{ print $4 }')

$B echo "" >> $LOG
$B echo "[$TIME] 006 - ***GPU gear***" >> $LOG
$B echo "Remounting /system - RW" >> $LOG
$B mount -o remount,rw /system
if [ -e /system/lib/egl/libGLESv2_adreno200.so ]; then
 AV=$(du -k "/system/lib/egl/libGLESv2_adreno200.so" | cut -f1)
 $B sleep 1
 $B echo "Adreno GPU detected" >> $LOG
 if [ ! -h /data/local/tmp/adreno_config.txt ]; then
 $B echo "Applying Adreno configurations.." >> $LOG
 $B chmod 777 /system/engine/assets/adreno_config.txt
 $B ln -s /system/engine/assets/adreno_config.txt /data/local/tmp/adreno_config.txt
 fi;
 if [ -e /sys/devices/platform/kgsl/msm_kgsl/kgsl-3d0/io_fraction ]; then
 $B echo 50 > /sys/devices/platform/kgsl/msm_kgsl/kgsl-3d0/io_fraction
 fi;
 if [ "$AV" -ne "1712" ]; then
 $B echo "Forcing GPU to render UI.." >> $LOG
 $B rm /system/lib/egl/libGLES_android.so
 $B sed -i '/0 0 android/d' /system/lib/egl/egl.cfg
 else
 $B echo "You have legacy adreno libs. No HWA for you." >> $LOG
 fi;
 $B mount -t debugfs debugfs /sys/kernel/debug
 $B echo "Setting correct device permissions.." >> $LOG
 $B chmod 666 /dev/kgsl-3d0
 $B chmod 666 /dev/msm_aac_in
 $B chmod 666 /dev/msm_amr_in
 $B chmod 666 /dev/genlock
 $B echo "Tuning Android and Adreno frienship.." >> $LOG
 setprop com.qc.hardware true
 setprop com.qc.hdmi_out false
 setprop debug.qc.hardware true
 setprop debug.qctwa.statusbar 1
 setprop debug.qctwa.perservebuf 1
fi;
$B mount -t debugfs debugfs /sys/kernel/debug
$B chmod 777 /dev/graphics/fb0
$B echo "Disabling VSYNC.." >> $LOG
$B echo 0 > /sys/kernel/debug/msm_fb/0/vsync_enable
if [ -e /system/xbin/sqlite3 ]; then
 if [ ! -e /data/local/animset ]; then
  if [ -e /data/data/com.android.providers.settings/databases/settings.db ]; then
   $B echo "Tuning Android animations.." >> $LOG
   echo "REPLACE INTO \"system\" VALUES(26,'window_animation_scale','0.25');REPLACE INTO \"system\" VALUES(27,'transition_animation_scale','0.25');" | sqlite3 /data/data/com.android.providers.settings/databases/settings.db
   $B kill `$B pidof system_server`
   $B echo "yes" > /data/local/animset
  fi;
 fi;
fi;

$B echo "Tuning Android graphics.." >> $LOG
setprop debug.sf.hw 1
setprop debug.egl.hw 1
setprop debug.egl.profiler 1
setprop debug.egl.swapinterval -60
setprop debug.gr.numframebuffers 3
setprop debug.gr.swapinterval 1
setprop debug.mdpcomp.logs 0
setprop debug.mdpcomp.maxlayer 3
setprop debug.mdpcomp.idletime -1
setprop debug.performance.tuning 1
setprop debug.enabletr true
setprop dev.pm.dyn_samplingrate 1
setprop ro.floatingtouch.available 1
setprop ro.min.fling_velocity 7000
setprop ro.max.fling_velocity 12000
setprop persist.sys.ui.hw 1
setprop video.accelerate.hw 1
setprop windowsmgr.max_events_per_sec 72
setprop windowsmgr.support_rotation_270 true
setprop hwui.render_dirty_regions false
setprop persist.sys.NV_FPSLIMIT 90
setprop persist.sys.NV_POWERMODE 1
setprop persist.sys.scrollingcache 3
setprop ro.media.dec.jpeg.memcap 8000000
setprop ro.media.enc.hprof.vid.bps 8000000
setprop ro.media.enc.jpeg.quality 100
setprop media.stagefright.enable-player true
setprop media.stagefright.enable-meta true
setprop media.stagefright.enable-scan true
setprop media.stagefright.enable-http true
setprop media.stagefright.enable-aac true
setprop media.stagefright.enable-qcp true
setprop media.stagefright.enable-record true
setprop touch.presure.scale 0.1
setprop persist.service.lgospd.enable false
setprop persist.service.pcsync.enable false
setprop ro.lge.proximity.delay 25
setprop mot.proximity.delay 25
setprop ro.telephony.call_ring.delay 0

if [ -e /sys/module/tpd_setting/parameters/tpd_mode ]; then
$B chmod 644 /sys/module/tpd_setting/parameters/tpd_mode
$B echo 1 > /sys/module/tpd_setting/parameters/tpd_mode
elif [ -e /sys/module/hid_magicmouse/parameters/scroll_speed ]; then
$B chmod 644 /sys/module/hid_magicmouse/parameters/scroll_speed
$B echo 63 > /sys/module/hid_magicmouse/parameters/scroll_speed
fi;

TIME=$($B date | $B awk '{ print $4 }')
$B echo "[$TIME] 006 - ***GPU gear*** - OK" >> $LOG
sync;

